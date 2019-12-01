defmodule WebAppWeb.LivePageController do
  use WebAppWeb, :controller
  require Logger

  import Phoenix.LiveView.Controller
  import TroFirmware.UiOptions, only: [dt_to_localtime: 1]

  def index_sine_cose(conn, _params) do
    conn
    |> live_render(, session: %{foo: :bar2})
  end

end
