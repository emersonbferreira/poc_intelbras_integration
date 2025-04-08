defmodule PocIntelbrasIntegration.Repo.Migrations.CreateCameras do
  use Ecto.Migration

  def change do
    create table(:cameras) do
      add :recorder_device_id, references(:recorder_devices, on_delete: :nothing), null: false
      add :channel, :integer, null: false
      add :name, :string, null: false

      timestamps()
    end
  end
end
