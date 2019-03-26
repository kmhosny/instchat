opts = { url: "redis://localhost:6379/0" }
Redis.current = Redis.new(opts)
Redis.current.client.logger = Rails.logger
