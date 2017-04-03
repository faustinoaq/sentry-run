# sentry-run

[![Build Status](https://travis-ci.org/faustinoaq/sentry-run.svg?branch=master)](https://travis-ci.org/faustinoaq/sentry-run)

A shard using [Sentry](https://github.com/samueleaton/sentry) for reload code changes with `Sentry.run`.

## Installation

Add this to your application's `shard.yml`:

```yaml
development_dependencies:
  sentry-run:
    github: faustinoaq/sentry-run
```

Then run `shards update`.

## Usage

1. Create a new process with `process = Sentry.config(...)`
2. Execute `Sentry.run(process) do ... end`

```crystal
require "kemal"
require "sentry-run"

get "/" do
  "Hello world"
end

process = Sentry.config("App", "crystal build src/app.cr", "./app")

Sentry.run(process) do
  Kemal.run
end
```

You can use `Sentry.run` for recompile and reload your code without external `sentry.cr`.

Default values:

```
process_name : String
build_command : String
run_command : String
build_args = [] of String
run_args = [] of String
files = ["src/**/*.cr", "src/**/*.ecr"]
should_build = true
```

## How does it work?

Basically this shard checks a `sentry.lock` file.

When you run your code `Sentry.run` create a `sentry.lock` and then yield a block. After a code change Sentry recompiles your file and rerun a new app instance with `run_command` in `Sentry.config`.

## Contributing

1. Fork it ( https://github.com/faustinoaq/sentry-run/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Disclaimer

`Sentry.run` is intended for use in a development environment.

## Contributors

- [faustinoaq](https://github.com/faustinoaq) Faustino Aguilar - creator, maintainer
