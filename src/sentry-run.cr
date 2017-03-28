require "./sentry-run/*"

module Sentry
  def self.run
    Signal::INT.trap do
      exit
    end
    if File.exists?(Config::INSTANCE.lock)
      yield
    else
      File.write(Config::INSTANCE.lock, "")
      at_exit do
        File.delete(Config::INSTANCE.lock)
      end
      spawn do
        Config::INSTANCE.process.run
      end
      loop do
        sleep 1
      end
    end
  end
end
