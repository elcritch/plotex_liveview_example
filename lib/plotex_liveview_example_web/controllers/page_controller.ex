defmodule PlotexLiveViewExampleWeb.PageController do
  use PlotexLiveViewExampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
