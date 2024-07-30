defmodule JuabadoWeb.ActivitiesJSON do
  alias Juabado.Activities.Activity

  def index(%{activities: activities}) do
    %{data: for(activity <- activities, do: data(activity))}
  end

  defp data(%Activity{} = datum) do
		%{
      id: datum.id,
      name: datum.name,
      color: datum.color,
      icon: datum.icon,
      pointsperhour: datum.pointsperhour,
      secondsfree: datum.secondsfree
		}
	end
end
