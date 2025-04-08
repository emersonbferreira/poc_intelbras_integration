defmodule PocIntelbrasIntegration.Repo.Migrations.AddUsernamePasswordToRecorderDevices do
  use Ecto.Migration

  def change do
    alter table(:recorder_devices) do
      add :username, :string, null: false, default: "admin"
      add :password, :string, null: false, default: "admin"
    end
  end
end
