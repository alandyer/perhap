defmodule Perhap.PingHandler do
  use Perhap.Handler
  alias Perhap.Response

  def handle("GET", conn, state) do
    {:ok, conn |> Response.send(200, %{status: "ACK"}), state}
  end
end
