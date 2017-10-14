defmodule Perhap.Adapters.Eventstore.Dynamo do
  use Perhap.Adapters.Eventstore
  use GenServer

  #alias __MODULE__


  def start_link(args) do
    {:ok, pid} = GenServer.start_link(__MODULE__, args)
  end

  def put_event(event) do
    event2 = %Perhap.Event{event | metadata: Map.from_struct(event.metadata)}
    ExAws.Dynamo.put_item("Events", Map.from_struct(event2))
    |> ExAws.request!
  end

  def get_event(event_id) do
    ExAws.Dynamo.get_item("Events", %{event_id: event_id})
    |> ExAws.request!
  end

  def get_events(context, opts \\ []) do
    {:ok, :thng}
  end
end
