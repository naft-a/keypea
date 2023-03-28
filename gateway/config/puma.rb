# frozen_string_literal: true

max_threads_count = ENV.fetch("PUMA_MAX_THREADS", 5)
min_threads_count = ENV.fetch("PUMA_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

port        ENV.fetch("PUMA_PORT", ENV.fetch("PORT", 5001))
environment ENV.fetch("HANAMI_ENV", "development")
workers     ENV.fetch("PUMA_WORKERS", 2)

on_worker_boot do
  Hanami.shutdown
end

preload_app!
