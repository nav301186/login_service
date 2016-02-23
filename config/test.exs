use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :login_service, LoginService.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :login_service, LoginService.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "ums",
  password: "password",
  database: "ums_development",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox


  config :guardian, Guardian,
          issuer: "LoginService",
          allowed_algos: ["HS512"],
          verify_module: Guardian.JWT,
          ttl: {30, :days },
          verify_issuer: true,
          secret_key: "wWJxTwhe0ccfmgHpNBJTmbd5Zrc2bXvDCa2BtLRW8GjTYaN",
          serializer: LoginService.GuardianSerializer

  config :arc,
         definition: Arc.Storage.Local
