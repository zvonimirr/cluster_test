defmodule ClusterTest.Node do
  @moduledoc """
  This module contains the helper functions for dealing with nodes.
  """

  @doc """
  This function returns all the nodes that respond to a ping and that
  are connected. If none are available, it returns an empty list.
  Note: The local node is not included in the list.

  Example:
      iex(app@whistleblower)1> ClusterTest.Node.connect_all_nodes
      [:app@whistleblower]
  """
  @spec connect_all_nodes :: list
  def connect_all_nodes do
    nodes =
      case Application.fetch_env(:cluster_test, :nodes) do
        :error -> []
        {:ok, nodes} -> nodes
      end

    nodes
    |> Enum.filter(&is_node_alive?/1)
    |> Enum.filter(&Node.connect/1)
  end

  defp is_node_alive?(node) do
    Node.ping(node) == :pong
  end

end
