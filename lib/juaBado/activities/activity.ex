defmodule Juabado.Activities.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activities" do
    field :name, :string
    field :color, :string
    field :icon, :string
    field :pointsperhour, :float
    field :secondsfree, :integer

    timestamps(type: :utc_datetime)

    has_many :stamps, Juabado.Stamps.Stamp
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:color, :name, :icon, :pointsperhour, :secondsfree])
    |> validate_required([:color, :name, :icon, :pointsperhour, :secondsfree])
  end
end
