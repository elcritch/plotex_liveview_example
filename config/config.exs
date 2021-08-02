# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :plotex_liveview_example, PlotexLiveviewExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WU/3Jm9/tftQt+2PWaMQbewm/2w6KCfgZqihv1Z1wbR+IvprIomLGmuOCSfGnTab",
  render_errors: [view: PlotexLiveviewExampleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PlotexLiveviewExample.PubSub,
  live_view: [signing_salt: "Mr66491z"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
