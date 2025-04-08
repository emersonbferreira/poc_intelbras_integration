defmodule PocIntelbrasIntegration.Repo.Migrations.CreateSnapshots do
  use Ecto.Migration

  def change do
    create table(:snapshots) do
      add :camera_id, references(:cameras, on_delete: :nothing), null: false
      add :image, :binary, null: false
      add :timestamp, :utc_datetime, null: false

      timestamps()
    end
  end
end
