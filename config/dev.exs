use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :login_service, LoginService.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development.
# Do not configure such in production as keeping
# and calculating stacktraces is usually expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :login_service, LoginService.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "ums",
  password: "password",
  database: "ums_development",
  hostname: "localhost",
  pool_size: 10

  # config :joken, config_module: Guardian.JWT

  config :guardian, Guardian,
          issuer: "LoginService",
          allowed_algos: ["HS512"],
          verify_module: Guardian.JWT,
          ttl: {30, :days },
          verify_issuer: true,
          secret_key: "wWJxTwhe0ccfmgHpNBJTmbd5Zrc2bXvDCa2BtLRW8GjTYaN",
          serializer: LoginService.GuardianSerializer
