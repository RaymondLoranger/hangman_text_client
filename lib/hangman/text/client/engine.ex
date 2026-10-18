defmodule Hangman.Text.Client.Engine do
  @moduledoc """
  Starts a game locally or remotely:

    - locally when local node is not alive (`:nonode@nohost`)
    - remotely on node `:hangman_engine@<hostname>` otherwise
  """

  use PersistConfig

  alias IO.ANSI.Plus, as: ANSI
  alias Hangman.{Engine, Game}
  alias Hangman.Text.Client
  alias Hangman.Text.Client.Message

  @doc """
  Starts locally or remotely a _Hangman Game_ named `game_name`.
  """
  @spec new_game(Game.name()) :: Game.name() | no_return
  def new_game(game_name), do: node() |> new_game(game_name)

  ## Private functions

  @spec new_game(node, Game.name()) :: Game.name() | no_return
  defp new_game(local_node = :nonode@nohost, game_name) do
    {:ok, _apps} = Application.ensure_all_started(:hangman_engine)
    {:ok, pid} = Engine.new_game(game_name)
    Message.game_started(game_name, local_node, pid) |> ANSI.puts()
    game_name
  end

  defp new_game(local_node, game_name) do
    engine_node = Client.engine_node()

    if Node.connect(engine_node) do
      Message.connected_to_node(local_node, engine_node) |> ANSI.puts()
    else
      Message.cannot_connect_to_node(local_node, engine_node) |> ANSI.puts()
      System.stop(0)
    end

    # Synchronizes the global name server with all nodes known to this node.
    :ok = :global.sync()

    # Remote procedure call to call a function on a remote node.
    case :rpc.call(engine_node, Engine, :new_game, [game_name]) do
      {:ok, pid} ->
        Message.game_started(game_name, engine_node, pid) |> ANSI.puts()
        game_name

      # E.g. `Hangman.Text.Client.start("scaffold")` on 2 client nodes.
      {:error, {:already_started, _pid}} ->
        Message.game_already_started(game_name, engine_node) |> ANSI.puts()
        System.stop(0)

      # Extremely unlikely since we've already connected at this point.
      {:badrpc, :nodedown} ->
        Message.engine_node_down(engine_node) |> ANSI.puts()
        System.stop(0)

      # E.g. `iex --sname hangman_engine` without adding option `-S mix`.
      {:badrpc, {:EXIT, {:undef, _}}} ->
        Message.engine_not_started(engine_node) |> ANSI.puts()
        System.stop(0)

      # `:noproc` when client node itself is `:hangman_engine@<hostname>`
      # or on the engine node after app `:hangman_engine` crashed/exited.
      # To fix the issue: Application.ensure_all_started(:hangman_engine)
      {:badrpc, {:EXIT, {:noproc, _}}} ->
        Message.ensure_engine_started(engine_node) |> ANSI.puts()
        System.stop(0)

      error ->
        exit(error)
    end
  end
end
