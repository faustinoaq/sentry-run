# sentry-run

A shards using Sentry for reload code changes with `Sentry.run`.

## Installation

Add this to your application's `shard.yml`:

```yaml
development_dependencies:
  sentry-run:
    github: faustinoaq/sentry-run
```

Then run `shards update`.

## Usage

```crystal
require "kemal"
require "sentry-run"

get "/" do
  "Hello world"
end

# Sentry.config(files: ["src/app.cr"])

Sentry.run do
  Kemal.run
end
```

You can use `Sentry.run` for recompile and reload a block without external `sentry.cr`.

Also you can use `Sentry.config`:

```crystal
Sentry.config(files: ["src/app.cr"])

# Default values
# process_name = "App"
# build_command = "crystal build #{__FILE__}"
# run_command = "./#{File.basename(__FILE__, ".cr")}"
# build_args = [] of String
# run_args = [] of String
# files = ["src/**/*.cr", "src/**/*.ecr"]
# should_build = true
```

## How does it work?

Basically this shards check a `sentry.lock` file.

When you run your code `Sentry.run` create a `sentry.lock` and then yield your code. After a code change Sentry recompile your file and rerun a new app instance with `run_command` in `Sentry.config`.

## Contributing

1. Fork it ( https://github.com/[your-github-name]/sentry-run/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Disclaimer

`Sentry.run` is intended for use in a development environment.

## Contributors

- [faustinoaq](https://github.com/faustinoaq) Faustino Aguilar - creator, maintainer
