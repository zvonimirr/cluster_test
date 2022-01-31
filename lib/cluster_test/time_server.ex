defmodule ClusterTest.TimeServer do
  @moduledoc """
  This module implements a GenServer which will
  return the current time of the node it's running on.
  """
  use GenServer

  # Client
  @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @doc """
  This function runs an infinite loop, returning the current time of
  all nodes and printing the result.
  """
  @spec fetch_times :: no_return
  def fetch_times do
    :timer.sleep(1_000)
    IEx.Helpers.clear()
    do_fetch_times(Node.list())
    fetch_times()
  end

  defp do_fetch_times([]) do
    [:color196, "No nodes in cluster"]
    |> Bunt.puts()
  end

  defp do_fetch_times(nodes) do
    nodes
    |> Enum.map(&fetch_node_time/1)
    |> Enum.each(fn [node, time] ->
      [
        :color255,
        "Time at ",
        :color33,
        Atom.to_string(node),
        :color255,
        " is ",
        :color118,
        Timex.format!(time, "%Y-%m-%d %H:%M:%S", :strftime)
      ]
      |> Bunt.puts()
    end)
  end

  defp fetch_node_time(node) do
    response = GenServer.call({__MODULE__, node}, :fetch_time)

    case response do
      {:ok, time} ->
        [node, time]

      _ ->
        [node, "Unknown"]
    end
  end

  # Server
  @impl GenServer
  def init(_), do: {:ok, nil}

  @impl GenServer
  def handle_call(:fetch_time, _from, state) do
    {:reply, {:ok, Timex.now()}, state}
  end
end
