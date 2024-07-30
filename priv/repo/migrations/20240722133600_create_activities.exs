defmodule Juabado.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do

    drop_if_exists table(:activities)

    create table(:activities, if_not_exists: true) do
      add :color, :string
      add :name, :string, null: false
      add :icon, :string, default: "⭕"
      add :pointsperhour, :float, default: 0
      add :secondsfree, :integer, default: 0

      timestamps(type: :utc_datetime)
    end

    create unique_index(:activities, [:name], name: :index_for_duplicate_names)
  end
end
