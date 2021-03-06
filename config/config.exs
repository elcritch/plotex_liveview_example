use Mix.Config

config :ex_cldr, default_locale: "en", json_library: Jason, default_backend: PlotexLiveViewExample.Cldr

config :plotex_liveview_example,
  namespace: PlotexLiveViewExample

# Configures the endpoint
config :plotex_liveview_example, PlotexLiveViewExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "AnXeKAdtZB191+4H6dvj52qoU0FjTYagBqSurS7EEQbNblv3qN/6MFAL4FfhJcoY",
  render_errors: [view: PlotexLiveViewExampleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PlotexLiveViewExample.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [ signing_salt: "eP2I3HKiZyuo07+cdm0TKh8IysjXBjXR" ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
