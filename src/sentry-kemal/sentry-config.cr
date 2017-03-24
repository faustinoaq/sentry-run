require "sentry"

module Sentry

  class Config
    NEW = new
    property process : Sentry::ProcessRunner = default

    def default
      Sentry::ProcessRunner.new(
        "Kemal",
        "crystal build #{__FILE__}",
        "./#{File.basename(__FILE__, ".cr")}",
        [] of String,
        [] of String,
        ["src/**/*.cr", "src/**/*.ecr"],
        true)
    end
  end

  def self.config(process_name = "Kemal",
                  build_command = "crystal build #{__FILE__}",
                  run_command = "./#{File.basename(__FILE__, ".cr")}",
                  build_args = [] of String,
                  run_args = [] of String,
                  files = ["src/**/*.cr", "src/**/*.ecr"],
                  should_build = true)
    Config::NEW.process = Sentry::ProcessRunner.new(
      process_name,
      build_command,
      run_command,
      build_args,
      run_args,
      files,
      should_build
    )
  end
end