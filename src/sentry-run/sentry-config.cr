require "sentry"

# Sentry config wrapper to create a new Sentry process
module Sentry
  def self.config(process_name : String,
                  build_command : String,
                  run_command : String,
                  build_args = [] of String,
                  run_args = [] of String,
                  files = ["src/**/*.cr", "src/**/*.ecr"],
                  should_build = true)
    Sentry::ProcessRunner.new(
      process_name,
      build_command,
      run_command,
      build_args,
      run_args,
      files,
      should_build)
  end
end
