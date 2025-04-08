defmodule PocIntelbrasIntegration.Repo do
  use Ecto.Repo,
    otp_app: :poc_intelbras_integration,
    adapter: Ecto.Adapters.Postgres
end
