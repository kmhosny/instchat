redis_host = ENV['REDIS_PORT_6379_TCP_ADDR']
redis_port = ENV['REDIS_PORT_6379_TCP_PORT']
Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{redis_host}:#{redis_port}/0" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis_host}:#{redis_port}/0" }
end

if Sidekiq.server?
  MessageWriteWorker.perform_async
end
