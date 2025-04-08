defmodule PocIntelbrasIntegration.RecorderDevices.RecorderDevice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recorder_devices" do
    field :name, :string
    field :model, :string
    field :brand, :string
    field :ip_address, :string
    field :username, :string, default: "admin"
    field :password, :string, default: "admin"

    has_many :cameras, PocIntelbrasIntegration.Cameras.Camera

    timestamps()
  end

  def changeset(recorder_device, attrs) do
    recorder_device
    |> cast(attrs, [:name, :model, :brand, :ip_address, :username, :password])
    |> validate_required([:name, :model, :brand, :ip_address, :username, :password])
  end
end
