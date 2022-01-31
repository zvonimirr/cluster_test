# Check the current node name.
node_name = node()
if node_name == :nonode@nohost do
  raise "You must specify a node name! (iex --sname <node name> -S mix)"
end

# Connect all nodes.
ClusterTest.Node.connect_all_nodes()
