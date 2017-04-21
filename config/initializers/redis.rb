if Rails.env.Production?
  redis = Redis.new(url: ENV["REDIS_URL"])
else
  redis = Redis.new(:host => 'localhost', :port => 6379)
end