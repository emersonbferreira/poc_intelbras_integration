defmodule PocIntelbrasIntegration.RecorderDevices do
  alias PocIntelbrasIntegration.Repo
  alias PocIntelbrasIntegration.RecorderDevices.RecorderDevice

  #example to create a new recorder device
  #PocIntelbrasIntegration.RecorderDevices.create_recorder_device(%{name: "DVR 1", model: "MHDX 1016", brand: "Intelbras", ip_address: "192.168.1.100"})
  def create_recorder_device(attrs) do
    %RecorderDevice{}
    |> RecorderDevice.changeset(attrs)
    |> Repo.insert()
  end

  def get_by_ip(ip_address) do
    Repo.get_by(RecorderDevice, ip_address: ip_address)
  end
end
