defmodule PlotexLiveViewExample.MixProject do
  use Mix.Project

  def project do
    [
      app: :plotex_liveview_example,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {PlotexLiveViewExample.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # {:plotex, "~> 0.2.3", github: "elcritch/plotex"},
      {:plotex, "~> 0.3.1"},
      # {:plotex, "~> 0.2.3", path: "../plotex/"},

      {:phoenix, "~> 1.5.8"},
      {:phoenix_live_view, "~> 0.15.1", override: true},
      {:floki, ">= 0.27.0", only: :test},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_dashboard, "~> 0.4"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:exsync, "~> 0.2", only: :dev},
      {:plug_cowboy, "~> 2.0"}

    ]
  end
end
