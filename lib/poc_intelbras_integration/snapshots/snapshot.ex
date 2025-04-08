defmodule PocIntelbrasIntegration.Snapshots.Snapshot do
  use Ecto.Schema
  import Ecto.Changeset

  schema "snapshots" do
    field :image, :binary
    field :timestamp, :utc_datetime

    belongs_to :camera, PocIntelbrasIntegration.Cameras.Camera

    timestamps()
  end

  def changeset(snapshot, attrs) do
    snapshot
    |> cast(attrs, [:image, :timestamp, :camera_id])
    |> validate_required([:image, :timestamp, :camera_id])
  end
end
