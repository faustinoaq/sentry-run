require "sentry"

module Sentry
  PROCESS_NAME  = "App"
  BUILD_COMMAND = "crystal build #{__FILE__}"
  RUN_COMMAND   = "./#{File.basename(__FILE__, ".cr")}"
  BUILD_ARGS    = [] of String
  RUN_ARGS      = [] of String
  FILES         = ["src/**/*.cr", "src/**/*.ecr"]
  SHOULD_BUILD  = true

  class Config
    INSTANCE = new
    property lock = "sentry.lock"
    property process : Sentry::ProcessRunner
    @process = Sentry::ProcessRunner.new(
      PROCESS_NAME,
      BUILD_COMMAND,
      RUN_COMMAND,
      BUILD_ARGS,
      RUN_ARGS,
      FILES,
      SHOULD_BUILD)
  end

  def self.config(
                  process_name = PROCESS_NAME,
                  build_command = BUILD_COMMAND,
                  run_command = RUN_COMMAND,
                  build_args = BUILD_ARGS,
                  run_args = RUN_ARGS,
                  files = FILES,
                  should_build = SHOULD_BUILD)
    Config::INSTANCE.process = Sentry::ProcessRunner.new(
      process_name,
      build_command,
      run_command,
      build_args,
      run_args,
      files,
      should_build)
  end
end
