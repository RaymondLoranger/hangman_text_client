# ┌──────────────────────────────────────────────────────────────┐
# │ Based on the course "Elixir for Programmers" by Dave Thomas. │
# └──────────────────────────────────────────────────────────────┘
defmodule Hangman.Text.Client do
  @moduledoc """
  Text client for the _Hangman Game_.
  
  ##### Based on the course [Elixir for Programmers](https://codestool.coding-gnome.com/courses/elixir-for-programmers) by Dave Thomas.
  """

  alias __MODULE__.{Engine, Player, State}
  alias Hangman.Game

  @doc """
  Starts locally or remotely a _Hangman Game_ named `game_name`.
  The default value for `game_name` is provided by function
  `Hangman.Game.random_name/0`.
  
  ## Locally when local node is not alive
  
  Start each client like so:
  
  ```
  cd hangman_text_client
  iex -S mix
  :observer.start() # optional
  Hangman.Text.Client.start()
  ```
  
  ## Remotely when local node is alive
  
  App `:hangman_engine` must run on node `:hangman_engine@<hostname>` where
  `<hostname>` is either the full host name if long names are used, or the first
  part of the full host name if short names are used.
  
  ### Short names
  
  Start the engine using a short name:
  
  ```
  cd hangman_engine
  iex --sname hangman_engine -S mix
  :observer.start() # optional
  ```
  
  Start each client in a different node using a short name:
  
  ```
  cd hangman_text_client
  set "MIX_ENV=dev" && iex --sname mike -S mix
  Hangman.Text.Client.start()
  ```
  
  ```
  cd hangman_text_client
  set "MIX_ENV=dev" && iex --sname joe -S mix
  Hangman.Text.Client.start()
  ```
  
  ```
  etc.
  ```
  
  ### Long names
  
  Start the engine using a long name:
  
  ```
  cd hangman_engine
  iex --name hangman_engine@rays.supratech.ca -S mix
  :observer.start() # optional
  ```
  
  Start each client in a different node:
  
  ```
  cd hangman_text_client
  set "MIX_ENV=prod" && iex --name mike@rays.supratech.ca -S mix
  Hangman.Text.Client.start()
  ```
  
  ```
  cd hangman_text_client
  set "MIX_ENV=prod" && iex --name joe@rays.supratech.ca -S mix
  Hangman.Text.Client.start()
  ```
  
  ```
  etc.
  ```
  
  ### Short names using releases
  
  Start the engine:
  
  ```
  cd hangman_engine
  iex --sname hangman_engine --cookie fortune -S mix
  :observer.start() # optional
  ```
  
  Start each client in a different node:
  
  ```
  cd hangman_text_client
  set RELEASE_NODE=mike@rays
  "_build/dev/rel/hangman_text_client/bin/hangman_text_client" start_iex
  Hangman.Text.Client.start()
  ```
  
  ```
  cd hangman_text_client
  set RELEASE_NODE=joe@rays
  "_build/dev/rel/hangman_text_client/bin/hangman_text_client" start_iex
  Hangman.Text.Client.start()
  ```
  
  ```
  etc.
  ```
  
  ### Long names using releases
  
  Start the engine:
  
  ```
  cd hangman_engine
  iex --name hangman_engine@rays.supratech.ca --cookie fortune -S mix
  :observer.start() # optional
  ```
  
  Start each client in a different node:
  
  ```
  cd hangman_text_client
  set RELEASE_NODE=mike@rays.supratech.ca
  "_build/prod/rel/hangman_text_client/bin/hangman_text_client" start_iex
  Hangman.Text.Client.start()
  ```
  
  ```
  cd hangman_text_client
  set RELEASE_NODE=joe@rays.supratech.ca
  "_build/prod/rel/hangman_text_client/bin/hangman_text_client" start_iex
  Hangman.Text.Client.start()
  ```
  
  ```
  etc.
  ```
  """
  @spec start(Game.name()) :: no_return
  def start(game_name \\ Hangman.Game.random_name()) do
    Engine.new_game(game_name) |> State.new() |> Player.play()
  end
end
