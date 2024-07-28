defmodule JuaBado.Stamps do
  import Ecto.Query, warn: false
  alias JuaBado.Repo
  alias JuaBado.Stamps.Stamp

  def list_stamps do
    Repo.all(Stamp)
  end

  def list_complete_stamps do
    try do
      Repo.all(from s in Stamp, preload: [:activity])
    rescue
      e in Exception ->
        {:error, "Failed to fetch stamps: #{inspect(e)}"}
    end
  end

  def create_stamp_now(id, type) do
    current_time = DateTime.utc_now()
    create_stamp(%{activity_id: id, type: type, time: current_time})
  end

  def get_stamp!(id), do: Repo.get!(Stamp, id)

  def create_stamp(attrs \\ %{}) do
    changeset = Stamp.changeset(%Stamp{}, attrs)

    case Repo.insert(changeset) do
      {:ok, stamp} ->
        Phoenix.PubSub.broadcast(JuaBado.PubSub, "stamps_created", :db_updated)
        IO.inspect("Broadcast!!")
        {:ok, stamp}
      {:error, changeset} ->
        {:error, changeset}
    end
  end


  def update_stamp(%Stamp{} = stamp, attrs) do
    case Stamp.changeset(stamp, attrs) |> Repo.update() do
      {:ok, stamp} -> {:ok, stamp}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def delete_stamp(%Stamp{} = stamp) do
    case Repo.delete(stamp) do
      {:ok, _stamp} -> :ok
      {:error, reason} -> {:error, reason}
    end
  end

  def change_stamp(%Stamp{} = stamp, attrs \\ %{}) do
    Stamp.changeset(stamp, attrs)
  end
end
