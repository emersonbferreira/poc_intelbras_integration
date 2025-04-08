defmodule PocIntelbrasIntegrationWeb.Router do
  use PocIntelbrasIntegrationWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PocIntelbrasIntegrationWeb do
    pipe_through :api

    #example request
    #curl -X POST -H "Content-Type: application/json" -d '{"name": "DVR Principal", "model": "MHDX 1016", "brand": "Intelbras", "ip_address": "192.168.1.100", "username": "admin", "password": "admin"}' http://localhost:4000/api/recorder_devices
    post "/recorder_devices", RecorderDeviceController, :create

    #example request
    #curl -X POST -H "Content-Type: application/json" -d '{"event": "MotionDetect", "channel": 1, "time": "2025-04-07T14:00:00", "status": "start"}' http://localhost:4000/api/receive_event
    post "/receive_event", EventController, :receive_event
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:poc_intelbras_integration, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: PocIntelbrasIntegrationWeb.Telemetry
    end
  end
end
