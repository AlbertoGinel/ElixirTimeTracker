defmodule Juabado.ActivitiesTest do
  use Juabado.DataCase

  alias Juabado.Activities

  describe "juabado" do
    alias Juabado.Activities.Activity

    import Juabado.ActivitiesFixtures

    @invalid_attrs %{id: nil, name: nil, color: nil, icon: nil, pointsPerHour: nil, secondsFree: nil}

    test "list_juabado/0 returns all juabado" do
      activity = activity_fixture()
      assert Activities.list_juabado() == [activity]
    end

    test "get_activity!/1 returns the activity with given id" do
      activity = activity_fixture()
      assert Activities.get_activity!(activity.id) == activity
    end

    test "create_activity/1 with valid data creates a activity" do
      valid_attrs = %{id: "some id", name: "some name", color: "some color", icon: "some icon", pointsPerHour: 120.5, secondsFree: 42}

      assert {:ok, %Activity{} = activity} = Activities.create_activity(valid_attrs)
      assert activity.id == "some id"
      assert activity.name == "some name"
      assert activity.color == "some color"
      assert activity.icon == "some icon"
      assert activity.pointsPerHour == 120.5
      assert activity.secondsFree == 42
    end

    test "create_activity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Activities.create_activity(@invalid_attrs)
    end

    test "update_activity/2 with valid data updates the activity" do
      activity = activity_fixture()
      update_attrs = %{id: "some updated id", name: "some updated name", color: "some updated color", icon: "some updated icon", pointsPerHour: 456.7, secondsFree: 43}

      assert {:ok, %Activity{} = activity} = Activities.update_activity(activity, update_attrs)
      assert activity.id == "some updated id"
      assert activity.name == "some updated name"
      assert activity.color == "some updated color"
      assert activity.icon == "some updated icon"
      assert activity.pointsPerHour == 456.7
      assert activity.secondsFree == 43
    end

    test "update_activity/2 with invalid data returns error changeset" do
      activity = activity_fixture()
      assert {:error, %Ecto.Changeset{}} = Activities.update_activity(activity, @invalid_attrs)
      assert activity == Activities.get_activity!(activity.id)
    end

    test "delete_activity/1 deletes the activity" do
      activity = activity_fixture()
      assert {:ok, %Activity{}} = Activities.delete_activity(activity)
      assert_raise Ecto.NoResultsError, fn -> Activities.get_activity!(activity.id) end
    end

    test "change_activity/1 returns a activity changeset" do
      activity = activity_fixture()
      assert %Ecto.Changeset{} = Activities.change_activity(activity)
    end
  end
end
