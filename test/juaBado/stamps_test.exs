defmodule Juabado.StampsTest do
  use Juabado.DataCase

  alias Juabado.Stamps

  describe "juabado" do
    alias Juabado.Stamps.Stamp

    import Juabado.StampsFixtures

    @invalid_attrs %{type: nil, time: nil, activity_id: nil}

    test "list_juabado/0 returns all juabado" do
      stamp = stamp_fixture()
      assert Stamps.list_juabado() == [stamp]
    end

    test "get_stamp!/1 returns the stamp with given id" do
      stamp = stamp_fixture()
      assert Stamps.get_stamp!(stamp.id) == stamp
    end

    test "create_stamp/1 with valid data creates a stamp" do
      valid_attrs = %{type: "some type", time: ~N[2024-07-21 21:29:00], activity_id: "some activity_id"}

      assert {:ok, %Stamp{} = stamp} = Stamps.create_stamp(valid_attrs)
      assert stamp.type == "some type"
      assert stamp.time == ~N[2024-07-21 21:29:00]
      assert stamp.activity_id == "some activity_id"
    end

    test "create_stamp/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stamps.create_stamp(@invalid_attrs)
    end

    test "update_stamp/2 with valid data updates the stamp" do
      stamp = stamp_fixture()
      update_attrs = %{type: "some updated type", time: ~N[2024-07-22 21:29:00], activity_id: "some updated activity_id"}

      assert {:ok, %Stamp{} = stamp} = Stamps.update_stamp(stamp, update_attrs)
      assert stamp.type == "some updated type"
      assert stamp.time == ~N[2024-07-22 21:29:00]
      assert stamp.activity_id == "some updated activity_id"
    end

    test "update_stamp/2 with invalid data returns error changeset" do
      stamp = stamp_fixture()
      assert {:error, %Ecto.Changeset{}} = Stamps.update_stamp(stamp, @invalid_attrs)
      assert stamp == Stamps.get_stamp!(stamp.id)
    end

    test "delete_stamp/1 deletes the stamp" do
      stamp = stamp_fixture()
      assert {:ok, %Stamp{}} = Stamps.delete_stamp(stamp)
      assert_raise Ecto.NoResultsError, fn -> Stamps.get_stamp!(stamp.id) end
    end

    test "change_stamp/1 returns a stamp changeset" do
      stamp = stamp_fixture()
      assert %Ecto.Changeset{} = Stamps.change_stamp(stamp)
    end
  end
end
