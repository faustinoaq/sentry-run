require "./sentry-kemal/*"

module Sentry
  LOCK = "kemal.lock"
  def self.run
    Signal::INT.trap do
      exit
    end
    unless File.exists?(LOCK)
      File.write(LOCK, "")
      at_exit do
        File.delete(LOCK)
      end
      spawn do
        Config::NEW.process.run
      end
      loop do
        sleep 1
      end
    else
      yield
    end
  end
end
