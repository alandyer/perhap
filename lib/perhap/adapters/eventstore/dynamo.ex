defmodule Perhap.Adapters.Eventstore.Dynamo do
  use Perhap.Adapters.Eventstore
  use GenServer

  #alias __MODULE__


  def start_link(args) do
    {:ok, pid} = GenServer.start_link(__MODULE__, args)
  end

  def put_event(event) do
    ExAws.Dynamo.put_item("Events", event)
    |> ExAws.request!

    :ok
  end

  def get_event(event_id) do
    dynamo_object = ExAws.Dynamo.get_item("Events", %{event_id: event_id})
    |> ExAws.request!

    case dynamo_object do
      %{"Item" => data} ->
        metadata = ExAws.Dynamo.decode_item(Map.get(dynamo_object, "Item") |> Map.get("metadata"), as: Perhap.Event.Metadata)

        event = ExAws.Dynamo.decode_item(dynamo_object, as: Perhap.Event)

        %Perhap.Event{event | metadata: metadata}
      %{} ->
        {:error, "Event not found"}
    end
  end

  def get_events(context, opts \\ []) do
    {:ok, :thng}
  end
end
