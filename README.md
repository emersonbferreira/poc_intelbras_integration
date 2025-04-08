# PocIntelbrasIntegration

This project is a Proof of Concept for the integration between Intelbras DVRs, NVRs and IP Cameras with support HTTP API 3.59.

This project not includes a authentication layers.

We assume that you have basic knowledge of Phoenix Framework and Elixir.
We assume that you have acess to Intelbras API documentation to configure your devices to send events to this application.

## Getting started

To start your Phoenix server:
  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

To create a new recorder device
`curl -X POST -H "Content-Type: application/json" -d '{"name": "DVR Principal", "model": "MHDX 1016", "brand": "Intelbras", "ip_address": "192.168.1.100", "username": "admin", "password": "admin"}' http://localhost:4000/api/recorder_devices`
    
To configure your device to send events to this app, you need to configure the device to send events to the following route: /api/receive_event (see intelbras API docummentation to configure your device)

example of expected request:
`#curl -X POST -H "Content-Type: application/json" -d '{"event": "MotionDetect", "channel": 1, "time": "2025-04-07T14:00:00", "status": "start"}' http://localhost:4000/api/receive_event`
