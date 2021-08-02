defmodule PlotexLiveViewExampleWeb.Router do
  use PlotexLiveViewExampleWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PlotexLiveViewExampleWeb do
    pipe_through :browser

    get "/", PageController, :index
    # get "/cosine_graphs.html", LivePageController, :index_cose
    # get "/sine_cosine_graphs.html", LivePageController, :index_sine_cose
    live "/cosine_graphs.html", CosineGraphLive
    live "/sine_cosine_graphs.html", SineCosineGraphLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", PlotexLiveViewExampleWeb do
  #   pipe_through :api
  # end
end
