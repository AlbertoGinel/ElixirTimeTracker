
activities_path = "priv/repo/activities.json"
activities_path
|> File.read!()
|> Jason.decode!()
|> Enum.each(fn attrs ->

  activity = %{
    name: Map.get(attrs, "name", nil), # Ensure name is not null
    color: Map.get(attrs, "color", "#FFFFFF"), # Default color to white if not provided
    icon: Map.get(attrs, "icon", "⭕"), # Default icon if not provided
    pointsPerHour: Map.get(attrs, "pointsPerHour", 0), # Default points per hour to 0 if not provided
    secondsFree: Map.get(attrs, "secondsFree", 0) # Default seconds free to 0 if not provided
  }

	case Juabado.Activities.create_activity(activity) do
		{:ok, _activity} -> :ok
		{:error, _changeset} -> :duplicate
	end
end)



stamps_path = "priv/repo/stamps.json"
stamps_path
|> File.read!()
|> Jason.decode!()
|> Enum.each(fn attrs ->
  stamp = %{
    time: Map.get(attrs, "time",nil),
    type: Map.get(attrs, "type",nil),
    activity_id: Map.get(attrs, "activity_id",nil)
  }

  IO.inspect(stamp)

  case Juabado.Stamps.create_stamp(stamp) do
    {:ok, _stamp} -> :ok
    {:error, _changeset} ->
      :duplicate
  end
end)
