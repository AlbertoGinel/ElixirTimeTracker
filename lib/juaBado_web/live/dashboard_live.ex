defmodule JuabadoWeb.DashboardLive do
  use Phoenix.LiveView
  use JuabadoWeb, :live_view
  import Timex

  alias HTTPoison
  alias Jason

  @impl true
  def mount(_params, _session, socket) do

    Phoenix.PubSub.subscribe(Juabado.PubSub, "stamps_created")

    activities_response = HTTPoison.get!("http://localhost:4000/api/activities")
    stamps_response = HTTPoison.get!("http://localhost:4000/api/stamps_complete")

    activities = Jason.decode!(activities_response.body)
    stamps = Jason.decode!(stamps_response.body)

    reversed_stamps = Enum.reverse(Enum.sort_by(stamps["data"], fn stamp -> stamp["time"] end))
    formatted_stamps = add_time_formatted(reversed_stamps)
    formatted_stamps2 = add_current_duration(formatted_stamps)

    Process.send_after(self(), :update_clock, 1000)


    {:ok, assign(socket, activities: activities["data"], stamps: formatted_stamps2), layout: false}
  end


  defp add_current_duration([first_stamp | rest] = stamps) do
    now = DateTime.utc_now()

    naive_datetime = Timex.parse!(first_stamp["time"], "{ISO:Extended}")

    datetime_utc = DateTime.from_naive!(naive_datetime, "Etc/UTC")

    duration_seconds = DateTime.diff(now, datetime_utc, :second)

    updated_first_stamp = Map.put(first_stamp, "howManySeconds", duration_seconds)

    [updated_first_stamp | rest]
  end

  defp update_clock(socket) do
    now = DateTime.utc_now()
    formatted_time = Timex.format!(now, "{HH24}:{mm}:{ss}", :strftime)

    {:noreply, assign(socket, time: formatted_time)}
  end



  @impl true
  def handle_event("start_activity", %{"id" => id}, socket) do
    # Convert the ID to an integer if necessary
    id = String.to_integer(id)

    # Prepare the payload
    payload = %{id: id, type: "start"}

    # Send the POST request
    case HTTPoison.post("http://localhost:4000/api/stamps/create_now", Jason.encode!(payload), [{"Content-Type", "application/json"}]) do
      {:ok, response} ->
        #push_patch(socket, to: Routes.dashboard_path(socket, :index))
        {:noreply, socket}

      {:error, error} ->
        # Handle error
        IO.puts("Error sending start activity request: #{inspect(error)}")
        {:noreply, socket}
    end
  end


  @impl true
  def handle_info({:stamps_created, _new_stamp}, socket) do
    # Fetch the updated stamps from the API or process the new_stamp
    stamps_response = HTTPoison.get!("http://localhost:4000/api/stamps_complete")
    stamps = Jason.decode!(stamps_response.body)
    reversed_stamps = Enum.reverse(Enum.sort_by(stamps["data"], fn stamp -> stamp["time"] end))

    {:noreply, assign(socket, stamps: reversed_stamps)}
  end

  @impl true
def handle_info(:update_clock, socket) do
  # Update the clock
  {:noreply, update(socket, :time, &update_clock/1)}

  # Schedule the next update
  Process.send_after(self(), :update_clock, 1000)

  # Continue processing other messages
  {:noreply, socket}
end


  defp add_time_formatted(stamps) do
    Enum.map(stamps, fn stamp ->
      time = stamp["time"]

      case Timex.parse(time, "{ISO:Extended}") do
        {:ok, naive_datetime} ->
          local_datetime = Timex.to_datetime(naive_datetime, Timex.local().time_zone)
          formatted_time = Timex.format!(local_datetime, "{h24}:{m} {0D}/{0M}/{YY}")
          Map.put(stamp, "time_formatted", formatted_time)

        {:error, reason} ->
          IO.puts("Error parsing datetime: #{inspect(reason)}")
          Map.put(stamp, "time_formatted", "Invalid date")
      end
    end)
  end

  @impl true
  def render(assigns) do
    ~H"""
      <div id="dashboard" class="flex flex-col md:flex-row">
        <div class="md:w-1/2 p-4">
          <!-- Current Activity -->
          <%= if @stamps != [] and hd(@stamps)["type"] == "start" do %>
            <% last_stamp = hd(@stamps) %>
            <div class="mb-4">
              <h2 class="text-xl font-bold mb-2">Current activity</h2>
              <% style = "background-color: #{last_stamp["color"]};" %>
              <li class="hover:bg-opacity-75 text-white font-bold py-2 px-4 rounded inline-flex items-center justify-between w-full" style={style}>
                <span><%= last_stamp["name"] %></span>
                <span class="ml-2"><%= last_stamp["icon"] %></span>
                <span><%= last_stamp["howManySeconds"] %></span>
                <span><%= last_stamp["time_formatted"] %></span>
              </li>
            </div>
          <% end %>

          <!-- Activities List -->
          <h2 class="text-xl font-bold mb-2">Activities</h2>
          <ul class="space-y-2">
            <%= for activity <- @activities do %>
              <% style = "background-color: #{activity["color"]};" %>
              <li class="hover:bg-opacity-75 text-white font-bold py-2 px-4 rounded inline-flex items-center justify-between w-full" style={style}>
                <span><%= activity["name"] %></span>
                <span class="ml-2"><%= activity["icon"] %></span>
                <button phx-click="start_activity" phx-value-id={activity["id"]} class="bg-green-500 hover:bg-green-700 text-white font-bold py-1 px-3 rounded ml-auto">Start Activity</button>
              </li>
            <% end %>
          </ul>
        </div>

        <div class="md:w-1/2 p-4 overflow-auto max-h-screen">
          <!-- Stamps List -->
          <h2 class="text-xl font-bold mb-2">Stamps</h2>
          <ul class="space-y-2">
            <%= for stamp <- @stamps do %>
              <% style = "background-color: #{stamp["color"]};" %>
              <li class="hover:bg-opacity-75 text-black font-semibold py-2 px-4 rounded inline-flex items-center justify-between w-full" style={style}>
                <span><%= stamp["name"] %></span>
                <span class="ml-2"><%= stamp["icon"] %></span>
                <span><%= stamp["time_formatted"] %></span>
              </li>
            <% end %>
          </ul>
        </div>
      </div>
    """
  end
end
