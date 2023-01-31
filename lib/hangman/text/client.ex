# ┌──────────────────────────────────────────────────────────────┐
# │ Based on the course "Elixir for Programmers" by Dave Thomas. │
# └──────────────────────────────────────────────────────────────┘
defmodule Hangman.Text.Client do
  @moduledoc """
  Text client for the _Hangman Game_.
  
  ##### Based on the course [Elixir for Programmers](https://codestool.coding-gnome.com/courses/elixir-for-programmers) by Dave Thomas.
  """

  alias __MODULE__.{Engine, Player, State}

  @doc """
  Starts a _Hangman Game_ locally or remotely.
  
  ## Locally when local node is not alive
  
  Start each client like so:
  
    - `cd hangman_text_client`
    - `iex -S mix`
    - `:observer.start() # optional`
    - `Hangman.Text.Client.start()`
  
  ## Remotely when local node is alive
  
  App `:hangman_engine` must run in node `:hangman_engine@<hostname>`
  where <hostname> is either the full host name if long names are used,
  or the first part of the full host name if short names are used.
  
  ### Short names
  
  Start the engine:
  
    - `cd hangman_engine`
    - `iex --sname hangman_engine -S mix`
    - `:observer.start() # optional`
  
  Start each client in a different node:
  
    - `cd hangman_text_client`
    - `set "MIX_ENV=dev" && iex --sname mike -S mix`
    - `Hangman.Text.Client.start()`
  
    * `cd hangman_text_client`
    * `set "MIX_ENV=dev" && iex --sname joe -S mix`
    * `Hangman.Text.Client.start()`
  
    - etc.
  
  ### Long names
  
  Start the engine:
  
    - `cd hangman_engine`
    - `iex --name hangman_engine@rays.supratech.ca -S mix`
    - `:observer.start() # optional`
  
  Start each client in a different node:
  
    - `cd hangman_text_client`
    - `set "MIX_ENV=prod" && iex --name mike@rays.supratech.ca -S mix`
    - `Hangman.Text.Client.start()`
  
    * `cd hangman_text_client`
    * `set "MIX_ENV=prod" && iex --name joe@rays.supratech.ca -S mix`
    * `Hangman.Text.Client.start()`
  
    - etc.
  
  ### Short names using releases
  
  Start the engine:
  
    - `cd hangman_engine`
    - `iex --sname hangman_engine --cookie fortune -S mix`
    - `:observer.start() # optional`
  
  Start each client in a different node:
  
    - `cd hangman_text_client`
    - `set RELEASE_NODE=mike@rays`
    - `"_build/dev/rel/hangman_text_client/bin/hangman_text_client" start_iex`
    - `Hangman.Text.Client.start()`
  
    * `cd hangman_text_client`
    * `set RELEASE_NODE=joe@rays`
    * `"_build/dev/rel/hangman_text_client/bin/hangman_text_client" start_iex`
    * `Hangman.Text.Client.start()`
  
    - etc.
  
  ### Long names using releases
  
  Start the engine:
  
    - `cd hangman_engine`
    - `iex --name hangman_engine@rays.supratech.ca --cookie fortune -S mix`
    - `:observer.start() # optional`
  
  Start each client in a different node:
  
    - `cd hangman_text_client`
    - `set RELEASE_NODE=mike@rays.supratech.ca`
    - `"_build/prod/rel/hangman_text_client/bin/hangman_text_client" start_iex`
    - `Hangman.Text.Client.start()`
  
    * `cd hangman_text_client`
    * `set RELEASE_NODE=joe@rays.supratech.ca`
    * `"_build/prod/rel/hangman_text_client/bin/hangman_text_client" start_iex`
    * `Hangman.Text.Client.start()`
  
    - etc.
  """
  @spec start :: no_return
  def start, do: node() |> Engine.new_game() |> State.new() |> Player.play()
end
