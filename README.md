# Cluster Test

This is a simple test project that gets the time of all connected nodes and prints it to the console.

## Installation

To install dependencies, run:
```bash
mix deps.get
```
**Don't forget to add your nodes to the list in `config.exs`**

**Nodes are connected automatically on runtime.**

To run the application run:
```bash
iex --name app@127.0.0.1 --cookie <cookie> -S mix
```
After that call the `fetch_times/0` function.
```
Erlang/OTP 23 [erts-11.1.8] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1]

Interactive Elixir (1.12.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(app@127.0.0.1)1> ClusterTest.TimeServer.fetch_times
```
