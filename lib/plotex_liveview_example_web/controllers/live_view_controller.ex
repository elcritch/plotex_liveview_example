defmodule PlotexLiveViewExampleWeb.LivePageController do
  use PlotexLiveViewExampleWeb, :controller
  require Logger

  import Phoenix.LiveView.Controller

  def index_cose(conn, _params) do
    live_render(conn, PlotexLiveViewExample.CosineGraphLive, session: %{})
  end

  def index_sine_cose(conn, _params) do
    live_render(conn, PlotexLiveViewExample.SineCosineGraphLive, session: %{})
  end

end
