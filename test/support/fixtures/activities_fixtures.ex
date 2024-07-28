defmodule JuaBado.ActivitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JuaBado.Activities` context.
  """

  @doc """
  Generate a activity.
  """
  def activity_fixture(attrs \\ %{}) do
    {:ok, activity} =
      attrs
      |> Enum.into(%{
        color: "some color",
        icon: "some icon",
        id: "some id",
        name: "some name",
        pointsPerHour: 120.5,
        secondsFree: 42
      })
      |> JuaBado.Activities.create_activity()

    activity
  end
end
