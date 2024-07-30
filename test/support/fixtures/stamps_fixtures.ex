defmodule Juabado.StampsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Juabado.Stamps` context.
  """

  @doc """
  Generate a stamp.
  """
  def stamp_fixture(attrs \\ %{}) do
    {:ok, stamp} =
      attrs
      |> Enum.into(%{
        activity_id: "some activity_id",
        time: ~N[2024-07-21 21:29:00],
        type: "some type"
      })
      |> Juabado.Stamps.create_stamp()

    stamp
  end
end
