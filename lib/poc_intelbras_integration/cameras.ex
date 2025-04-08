defmodule PocIntelbrasIntegration.Cameras do
  alias PocIntelbrasIntegration.Repo
  alias PocIntelbrasIntegration.Cameras.Camera

  def create_camera(attrs) do
    %Camera{}
    |> Camera.changeset(attrs)
    |> Repo.insert()
  end

  def get_by_channel_and_device(channel, recorder_device_id) do
    Repo.get_by(Camera, channel: channel, recorder_device_id: recorder_device_id)
  end
end
