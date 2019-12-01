defmodule PlotexLiveViewExample.DataHistoryLive do
  use Phoenix.LiveView
  # import Calendar.Strftime
  require Logger
  alias Plotex.Axis
  alias Plotex.Output.Options
  alias Plotex.Output.Options
  alias Plotex.Output.Formatter

  def graph_for_data(plt) do
    svg_str =
      Plotex.Output.Svg.generate(
        plt,
        %Options{
          xaxis: %Options.Axis{label: %Options.Item{rotate: 35}},
          width: 140,
          height: 105
        }
      )

    svg_str
  end

  def render(assigns) do
    ~L"""
      <article>
        <h3>TRO (ppm)</h3>
        <%= graph_for_data(@tro_ppm) %>
      </article>

      <style>
      </style>
    """
  end

  def mount(_session, socket) do
    Logger.warn("#{__MODULE__} mount self: #{inspect(self())} ")
    Logger.warn("#{__MODULE__} mount socket: #{inspect(socket)} ")

    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    socket! =
      socket
      |> put_date()
      |> assign(start: sdt)
      |> assign(stop: edt)

    {:ok, socket!}
  end

  def handle_info(:tick, socket) do

    socket! =
      socket
      |> put_date()
      |> put_graph_data()

    {:noreply, socket!}
  end

  defp put_date(socket) do
    assign(socket, date: NaiveDateTime.utc_now())
  end

  defp put_graph_data(socket) do
    # Logger.warn("#{__MODULE__} graph data: #{ inspect socket.assigns } ")
    xdata = socket.assigns.xdata
    ydata = socket.assigns.ydata

    udt = DateTime.utc_now()
    y = Math.sin( WebApp.Data.to_unix(udt)/10.0 )
    dt = udt |> dt_to_localtime()

    xdata! = Enum.take([dt | xdata], 1000)
    ydata! = Enum.take([y | ydata], 1000)

    assign(socket,
      xdata: xdata!,
      ydata: ydata!
    )
  end

end
