defmodule Juabado.ActivitiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Juabado.Activities` context.
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
        pointsperhour: 120.5,
        secondsfree: 42
      })
      |> Juabado.Activities.create_activity()

    activity
  end
end
