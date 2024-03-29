defmodule PlotexLiveviewExampleWeb.Router do
  use PlotexLiveviewExampleWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PlotexLiveviewExampleWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PlotexLiveviewExampleWeb do
    pipe_through :browser

    live "/", PageLive, :index
    live "/cosine", CosineGraphLive
    live "/sine_and_cosine", SineCosineGraphLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", PlotexLiveviewExampleWeb do
  #   pipe_through :api
  # end
end
