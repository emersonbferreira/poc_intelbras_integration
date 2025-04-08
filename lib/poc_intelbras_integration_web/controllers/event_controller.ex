defmodule PocIntelbrasIntegrationWeb.EventController do
  use PocIntelbrasIntegrationWeb, :controller
  alias PocIntelbrasIntegration.{RecorderDevices, Cameras, Snapshots}

  # Endpoint to receive events
  def receive_event(conn, params) do
    IO.inspect(params, label: "Received event")

    channel = Map.get(params, "channel")
    timestamp = Map.get(params, "time")

    if channel && timestamp do
      dvr_ip = conn.remote_ip |> :inet.ntoa() |> to_string()
      case RecorderDevices.get_by_ip(dvr_ip) do
        nil ->
          send_resp(conn, 400, "DVR device not registered")
        recorder_device ->
          # Fetches or creates the camera associated with the channel
          camera =
            case Cameras.get_by_channel_and_device(channel, recorder_device.id) do
              nil ->
                {:ok, camera} = Cameras.create_camera(%{
                  channel: channel,
                  name: "Camera #{channel}",
                  recorder_device_id: recorder_device.id
                })
                camera
              camera ->
                camera
            end

          # Requests the snapshot and saves it in the database
          case request_snapshot(recorder_device, channel) do
            {:ok, image_data} ->
              {:ok, _snapshot} = Snapshots.create_snapshot(%{
                camera_id: camera.id,
                image: image_data,
                timestamp: DateTime.from_iso8601(timestamp) |> elem(1)
              })
              json(conn, %{status: "success"})
            {:error, reason} ->
              send_resp(conn, 500, "Error getting snapshot: #{reason}")
          end
      end
    else
      send_resp(conn, 400, "Channel or timestamp not found in the event")
    end
  end

  # Function to request the snapshot from the DVR
  defp request_snapshot(recorder_device, channel) do
    url = "http://#{recorder_device.ip_address}/cgi-bin/snapshot.cgi?channel=#{channel}"
    auth = Base.encode64("#{recorder_device.username}:#{recorder_device.password}")

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
end