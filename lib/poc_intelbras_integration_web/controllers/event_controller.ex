defmodule PocIntelbrasIntegrationWeb.EventController do
  use PocIntelbrasIntegrationWeb, :controller

  # DVR settings
  @dvr_ip "192.168.1.100"
  @dvr_user "admin"
  @dvr_pass "dvr_password"

  # Endpoint to receive events
  def receive_event(conn, params) do
    IO.inspect(params, label: "Received event")

    case Map.get(params, "channel") do
      nil ->
        send_resp(conn, 400, "Channel not found in event")
      channel ->
        case request_snapshot(channel) do
          {:ok, image_data} ->
            save_snapshot(image_data, channel, Map.get(params, "time"))
            json(conn, %{status: "success"})
          {:error, reason} ->
            send_resp(conn, 500, "Error getting snapshot: #{reason}")
        end
    end
  end

  # Function to request snapshot from DVR
  defp request_snapshot(channel) do
    url = "http://#{@dvr_ip}/cgi-bin/snapshot.cgi?channel=#{channel}"
    auth = Base.encode64("#{@dvr_user}:#{@dvr_pass}")

    headers = [
      {"Authorization", "Basic #{auth}"}
    ]

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: code}} ->
        {:error, "HTTP code #{code}"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, inspect(reason)}
    end
  end

  # Function to save the snapshot
  defp save_snapshot(image_data, channel, timestamp) do
    safe_timestamp = String.replace(timestamp || DateTime.utc_now() |> to_string(), ":", "-")
    filename = "snapshot_channel_#{channel}_#{safe_timestamp}.jpg"

    File.write!(filename, image_data)
    IO.puts("Image saved as #{filename}")
  end
end