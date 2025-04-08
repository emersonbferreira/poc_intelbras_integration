defmodule PocIntelbrasIntegrationWeb.RecorderDeviceController do
  use PocIntelbrasIntegrationWeb, :controller
  alias PocIntelbrasIntegration.RecorderDevices

  # Endpoint to create a new recorder_device
  def create(conn, params) do
    case RecorderDevices.create_recorder_device(params) do
      {:ok, recorder_device} ->
        conn
        |> put_status(:created)
        |> json(%{
          status: "success",
          data: %{
            id: recorder_device.id,
            name: recorder_device.name,
            model: recorder_device.model,
            brand: recorder_device.brand,
            ip_address: recorder_device.ip_address,
            username: recorder_device.username
          }
        })
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{
          status: "error",
          errors: format_errors(changeset)
        })
    end
  end

  defp format_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
