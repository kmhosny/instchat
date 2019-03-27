redis_host = ENV['REDIS_PORT_6379_TCP_ADDR']
redis_port = ENV['REDIS_PORT_6379_TCP_PORT']
opts = { url: "redis://#{redis_host}:#{redis_port}/0" }
Redis.current = Redis.new(opts)
Redis.current.client.logger = Rails.logger
