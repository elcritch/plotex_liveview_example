defmodule PlotexLiveViewExample.LivePageController do
  use PlotexLiveViewExample, :controller
  require Logger

  import Phoenix.LiveView.Controller

  def index_sine_cose(conn, _params) do
    live_render(conn)
  end

end
