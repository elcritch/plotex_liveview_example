defmodule PlotexLiveViewExample.CosineGraphLive do
  use Phoenix.LiveView
  require Logger
  alias Plotex.Axis
  alias Plotex.ViewRange
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
        <h3>Graphs</h3>
        <%= graph_for_data(@plt) %>
      </article>

      <style>
        <%= Plotex.Output.Svg.default_css() %>
      </style>
    """
  end

  def mount(_session, socket) do
    Logger.warn("#{__MODULE__} mount self: #{inspect(self())} ")
    Logger.warn("#{__MODULE__} mount socket: #{inspect(socket)} ")

    if connected?(socket), do: :timer.send_interval(100, self(), :tick)

    edt = DateTime.utc_now()
    sdt = edt |> DateTime.add(-3600, :second)

    socket! =
      socket
      |> put_date()
      |> assign(start: sdt)
      |> assign(stop: edt)
      |> assign(xdata: [])
      |> assign(ydata: [])
      |> update_plot()

    {:ok, socket!}
  end

  def handle_info(:tick, socket) do

    socket! =
      socket
      |> put_date()
      |> update_plot()

    {:noreply, socket!}
  end

  defp put_date(socket) do
    assign(socket, date: DateTime.utc_now())
  end

  defp update_plot(socket) do
    # Logger.warn("#{__MODULE__} graph data: #{ inspect socket.assigns } ")
    xdata = socket.assigns.xdata
    ydata = socket.assigns.ydata

    dt = DateTime.utc_now()
    y = :math.sin( DateTime.to_unix(dt, :millisecond) / 5.0e3 )

    xdata! = Enum.take([dt | xdata], 1000)
    ydata! = Enum.take([y | ydata], 1000)

    plt = Plotex.plot(
      [{xdata!, ydata!}],
      xaxis: [
        units: %Axis.Units.Time{},
        formatter: %Formatter.DateTime.Cldr{},
        ticks: 4,
        width: 140,
        padding: 0.05,
        view_min: %ViewRange{stop: dt, start: dt |> DateTime.add(-10, :second)},
      ],
      yaxis: [
        view_min: %ViewRange{start: -1.0, stop: 1.0},
      ]
    )

    assign(socket,
      xdata: xdata!,
      ydata: ydata!,
      plt: plt,
    )
  end

end
