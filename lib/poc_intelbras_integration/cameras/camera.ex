defmodule PocIntelbrasIntegration.Cameras.Camera do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cameras" do
    field :channel, :integer
    field :name, :string

    belongs_to :recorder_device, PocIntelbrasIntegration.RecorderDevices.RecorderDevice
    has_many :snapshots, PocIntelbrasIntegration.Snapshots.Snapshot

    timestamps()
  end

  def changeset(camera, attrs) do
    camera
    |> cast(attrs, [:channel, :name, :recorder_device_id])
    |> validate_required([:channel, :name, :recorder_device_id])
  end
end
