require "json"

# Provides a set of helpers for a test suite that help to mock out the Stripe
# API.
module APIStubHelpers
  protected

  # Uses Webmock to stub out the Stripe API for testing purposes. The stub will
  # by default respond on any routes that are defined in the bundled OpenAPI
  # spec with generated response data.
  #
  # An `override_app` can be specified to get finer grain control over how a
  # stubbed endpoint responds. It can be used to modify generated responses,
  # mock expectations, or even to override the default stub completely.
  def stub_api
    stub_request(:any, /^#{Stripe.api_base}/).to_rack(new_api_stub)
  end

  def stub_connect
    stub_request(:any, /^#{Stripe.connect_base}/).to_return(:body => "{}")
  end

  private

  # APIStubMiddleware intercepts a response generated by Committee's stubbing
  # middleware, and tries to replace it with a better version from a set of
  # sample fixtures data generated from Stripe's core API service.
  class APIStubMiddleware
    API_FIXTURES = APIFixtures.new

    def initialize(app)
      @app = app
    end

    def call(env)
      # We use a vendor specific prefix (`x-resourceId`) embedded in the schema
      # of any resource in our spec to identify it (e.g. "charge"). This allows
      # us to cross-reference that response with some data that we might find
      # in our fixtures file so that we can respond with a higher fidelity
      # response.
      schema = env["committee.response_schema"]
      resource_id = schema.data["x-resourceId"] || ""

      if data = API_FIXTURES[resource_id.to_sym]
        # standard top-level API resource
        data = fixturize_lists_recursively(schema, data)
        env["committee.response"] = data
      elsif schema.properties["object"].enum == ["list"]
        # top level list (like from a list endpoint)
        data = fixturize_list(schema, env["committee.response"])
        env["committee.response"] = data
      else
        raise "no fixture for: #{resource_id}"
      end
      @app.call(env)
    end

    private

    # If schema looks like a Stripe list object, then we look up the resource
    # that the list is supposed to include and inject it into `data` as a
    # fixture. Also calls into that other schema recursively so that sublists
    # within it will also be assigned a fixture.
    def fixturize_list(schema, data)
      object_schema = schema.properties["object"]
      if object_schema && object_schema.enum == ["list"]
        subschema = schema.properties["data"].items
        resource_id = subschema.data["x-resourceId"] || ""
        if subdata = API_FIXTURES[resource_id.to_sym]
          subdata = fixturize_lists_recursively(subschema, subdata)

          data = data ? data.dup : {}
          data[:data] = [subdata]
        end
      end
      data
    end

    # Examines each of the given schema's properties and calls #fixturize_list
    # on them so that any sublists will be populated with sample fixture data.
    def fixturize_lists_recursively(schema, data)
      data = data.dup
      schema.properties.each do |key, subschema|
        data[key.to_sym] = fixturize_list(subschema, data[key.to_sym])
      end
      data
    end
  end

  # A descendant of the standard `Sinatra::Base` that we can use to enrich
  # certain types of responses.
  class APIStubApp < Sinatra::Base
    not_found do
      "endpoint not found in API stub: #{request.request_method} #{request.path_info}"
    end
  end

  # Finds the latest OpenAPI specification in ROOT/openapi/ and parses it for
  # use with Committee.
  def self.initialize_spec
    spec_data = ::JSON.parse(File.read("#{PROJECT_ROOT}/openapi/spec2.json"))

    driver = Committee::Drivers::OpenAPI2.new
    driver.parse(spec_data)
  end

  # Creates a new Rack app with Committee middleware it.
  def new_api_stub
    Rack::Builder.new {
      use Committee::Middleware::RequestValidation, schema: @@spec,
        params_response: true, strict: true
      use Committee::Middleware::Stub, schema: @@spec,
        call: true
      use APIStubMiddleware
      run APIStubApp.new
    }
  end

  # Parse and initialize the OpenAPI spec only once for the entire test suite.
  @@spec = initialize_spec

  # The default override app. Doesn't respond on any route so generated
  # responses will always take precedence.
  @@default_override_app = Sinatra.new
end