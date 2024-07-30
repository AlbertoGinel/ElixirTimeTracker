defmodule JuabadoWeb.StampsJSON do
  alias Juabado.Stamps.Stamp

  def index(%{stamps: stamps}) do
    %{data: for(stamp <- stamps, do: data(stamp))}
  end

  defp data(%Stamp{} = datum) do
		%{
      id: datum.id,
      time: datum.time,
      type: datum.type,
      activity_id: datum.activity_id
		}
	end

  def index_complete(%{stamps: stamps}) do
    %{data: Enum.map(stamps, &data_complete(&1))}
  end


  defp data_complete(%Stamp{} = stamp) do

    activity = stamp.activity || %{}

    %{
      id: stamp.id,
      type: stamp.type,
      time: stamp.time,
      activity_id: stamp.activity_id,
      name: activity.name,
      color: activity.color,
      icon: activity.icon
    }
  end

  def show (%{stamp: {:ok, stamp}}) do
    %{data: data(stamp)}
  end

end
