defmodule JuaBado.Stamps.Stamp do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Inspect, except: [:activity]}
  schema "stamps" do
    field :type, :string
    field :time, :naive_datetime

    timestamps(type: :utc_datetime)

    belongs_to :activity, JuaBado.Activities.Activity, foreign_key: :activity_id
  end

  @doc false
  def changeset(stamp, attrs) do
    stamp
    |> cast(attrs, [:time, :type, :activity_id])
    |> validate_required([:time, :type])
  end
end
