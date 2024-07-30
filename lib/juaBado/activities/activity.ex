defmodule Juabado.Activities.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activities" do
    field :name, :string
    field :color, :string
    field :icon, :string
    field :pointsPerHour, :float
    field :secondsFree, :integer

    timestamps(type: :utc_datetime)

    has_many :stamps, Juabado.Stamps.Stamp
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:color, :name, :icon, :pointsPerHour, :secondsFree])
    |> validate_required([:color, :name, :icon, :pointsPerHour, :secondsFree])
  end
end
