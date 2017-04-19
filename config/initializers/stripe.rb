if Rails.env.production?
  Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
    :secret_key => ENV['STRIPE_SECRET_KEY']
  }
else
  Rails.configuration.stripe = {
    :publishable_key => 'pk_test_WZSuST6VWOEHapaj41VDP4Ze',
    :secret_key => 'sk_test_5eWVJv5MERhlmKiKjbCQHJJ5'
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]