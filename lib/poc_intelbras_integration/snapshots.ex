defmodule PocIntelbrasIntegration.Snapshots do
  alias PocIntelbrasIntegration.Repo
  alias PocIntelbrasIntegration.Snapshots.Snapshot

  def create_snapshot(attrs) do
    %Snapshot{}
    |> Snapshot.changeset(attrs)
    |> Repo.insert()
  end
end