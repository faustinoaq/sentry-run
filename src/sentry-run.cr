require "./sentry-run/*"

module Sentry

  LOCK = "sentry.lock"

  # Check if `sentry.lock` exists then yield a block
  # If it doesn't exist then create a lock and execute a Sentry process.
  # When a Sentry process is finished the `sentry.lock` file is deleted
  # because Signal::INT has a trap for Ctrl+C and `at_exit` is executed.
  def self.run(process : Sentry::ProcessRunner)
    Signal::INT.trap do
      exit
    end
    if File.exists?(LOCK)
      yield
    else
      File.write(LOCK, "")
      at_exit do
        File.delete(LOCK)
      end
      process.run
    end
  end
end
