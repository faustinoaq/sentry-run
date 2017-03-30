require "./sentry-run/*"

module Sentry
  
  # Check if `sentry.lock` exists then yield a block
  # If it doesn't exist then create a lock and execute a Sentry process.
  # When a Sentry process is finished the `sentry.lock` file is deleted
  # because Signal::INT has a trap for Ctrl+C and `at_exit` is executed.
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
      Config::INSTANCE.process.run
    end
  end
end
