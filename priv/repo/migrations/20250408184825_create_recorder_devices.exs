defmodule PocIntelbrasIntegration.Repo.Migrations.CreateRecorderDevices do
  use Ecto.Migration

  def change do
    create table(:recorder_devices) do
      add :name, :string, null: false
      add :model, :string, null: false
      add :brand, :string, null: false
      add :ip_address, :string, null: false

      timestamps()
    end
  end
end
