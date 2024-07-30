defmodule juabado.Repo.Migrations.CreateStamps do
  use Ecto.Migration

  def change do

    drop_if_exists table(:stamps)

    create table(:stamps, if_not_exists: true) do
      add :time, :naive_datetime
      add :type, :string
      add :activity_id, references(:activities, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end
  end
end
