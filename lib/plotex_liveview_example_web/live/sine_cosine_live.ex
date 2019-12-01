defmodule PlotexLiveViewExample.SineCosineGraphLive do
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
      <article>
        <form phx-change="update">
          <label>Tick MS: <%= @speed %></label>
          <input type="range" min="10" max="2000" name="speed" value="<%= @speed %>" />
          <label>Count Max: <%= @count %></label>
          <input type="range" min="4" max="800" name="count" value="<%= @count %>" />
        </form>
      </article>
      <style>
        <%= Plotex.Output.Svg.default_css() %>
        .plx-dataset-0 {
          stroke: blue;
        }
        .plx-dataset-1 {
          stroke: red;
        }
        .plx-dataset-1 .plx-data-line {
          stroke: red;
        }
      </style>
    """
  end

  def mount(_session, socket) do
    Logger.warn("#{__MODULE__} mount self: #{inspect(self())} ")
    Logger.warn("#{__MODULE__} mount socket: #{inspect(socket)} ")

    edt = DateTime.utc_now()
    sdt = edt |> DateTime.add(-3600, :second)

    socket =
      socket
      |> put_date()
      |> assign(start: sdt)
      |> assign(stop: edt)
      |> assign(xdata: [])
      |> assign(ydata1: [])
      |> assign(ydata2: [])
      |> assign(ydata3: [])
      |> assign(count: 200)
      |> assign(speed: 1_000)
      |> update_plot()

    Process.send_after(self(), :tick, socket.assigns.speed)

    {:ok, socket}
  end

  def handle_event("update", event, socket) do
    Logger.info("cosine plot: speed: #{inspect event}")
    speed = event["speed"] |> String.to_integer()
    count = event["count"] |> String.to_integer()
    {:noreply, socket |> assign(speed: speed, count: count) }
  end

  def handle_info(:tick, socket) do
    socket =
      socket
      |> put_date()
      |> update_plot()

    Process.send_after(self(), :tick, socket.assigns.speed)

    # socket =
      # socket
      # |> update_plot()
    {:noreply, socket}
  end

  defp put_date(socket) do
    assign(socket, date: DateTime.utc_now())
  end

  defp update_plot(socket) do
    # Logger.warn("#{__MODULE__} graph data: #{ inspect socket.assigns } ")
    xdata = socket.assigns.xdata
    ydata1 = socket.assigns.ydata1
    ydata2 = socket.assigns.ydata2
    ydata3 = socket.assigns.ydata3

    dt = DateTime.utc_now()
    y1 = :math.sin( DateTime.to_unix(dt, :millisecond) / 3.0e3 )
    y2 = :math.cos( DateTime.to_unix(dt, :millisecond) / 3.0e3 )
    y3 = :math.cos( 0.45 + DateTime.to_unix(dt, :millisecond) / 3.0e3 )

    xdata = Enum.take([dt | xdata], socket.assigns.count)
    ydata1 = Enum.take([y1 | ydata1], socket.assigns.count)
    ydata2 = Enum.take([y2 | ydata2], socket.assigns.count)
    ydata3 = Enum.take([y3 | ydata3], socket.assigns.count)

    plt = Plotex.plot(
      [{xdata, ydata1}, {xdata, ydata2}, {xdata, ydata3}],
      xaxis: [
        units: %Axis.Units.Time{ticks: 4},
        formatter: %Formatter.DateTime.Cldr{},
        width: 140,
        padding: 0.05,
        view_min: %ViewRange{stop: dt, start: dt |> DateTime.add(-10, :second)},
      ],
      yaxis: [
        view_min: %ViewRange{start: -1.0, stop: 1.0},
      ]
    )

    assign(socket,
      xdata: xdata,
      ydata1: ydata1,
      ydata2: ydata2,
      ydata3: ydata3,
      plt: plt,
    )
  end

end
