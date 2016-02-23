# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :login_service, LoginService.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "M6e4xpMsKHA/cV9eZzUG0NPpucDIo2Zv0onbxM1f717dQosM/04fGnr61MvhPedF",
  render_errors: [accepts: ~w(json)],
  pubsub: [name: LoginService.PubSub,
           adapter: Phoenix.PubSub.PG2]
  # server: true

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

   config :phoenix, :format_encoders, "json-api": Poison
