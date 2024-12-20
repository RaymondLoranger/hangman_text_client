# ┌──────────────────────────────────────────────────────────────┐
# │ Based on the course "Elixir for Programmers" by Dave Thomas. │
# └──────────────────────────────────────────────────────────────┘
defmodule Hangman.Text.Client do
  @moduledoc """
  Text client for the _Hangman Game_.

  ##### Based on the course [Elixir for Programmers](https://codestool.coding-gnome.com/courses/elixir-for-programmers) by Dave Thomas.
  """

  use PersistConfig

  alias __MODULE__.{Engine, Player, State}
  alias Hangman.Game

  @doc """
  Starts locally or remotely a _Hangman Game_ named `game_name`.
  The default value for `game_name` is provided by function
  `Hangman.Game.random_name/0`.

  If you wish to use releases, see [release notes](https://github.com/RaymondLoranger/hangman_text_client/blob/main/release%20notes.txt).

  ## LOCALLY WHEN LOCAL NODE IS NOT ALIVE

  Start each client like so:

  ### *WITHOUT USING RELEASES*

  ```
  cd hangman_text_client
  iex -S mix
  :observer.start() # optional
  Hangman.Text.Client.start()
  ```

  ### *USING RELEASES*

  #### Commmand shell

  ```
  cd hangman_text_client
  "_build/nonode/rel/hangman_text_client/bin/hangman_text_client" start_iex
  :observer.start() # optional
  Hangman.Text.Client.start()
  ```

  #### PowerShell

  ```
  cd hangman_text_client
  _build/nonode/rel/hangman_text_client/bin/hangman_text_client start_iex
  :observer.start() # optional
  Hangman.Text.Client.start()
  ```

  ## REMOTELY WHEN LOCAL NODE IS ALIVE

  App `:hangman_engine` must run on node `:hangman_engine@<hostname>` where
  `<hostname>` is either the full host name if long names are used, or the first
  part of the full host name if short names are used.

  ### *SHORT NAMES WITHOUT USING RELEASES*

  Start the engine using a short name:

  ```
  cd hangman_engine
  iex --sname hangman_engine -S mix
  :observer.start() # optional
  ```

  Start a game from a different node with a short name:

  #### Commmand shell

  ```
  cd hangman_text_client
  set "MIX_ENV=dev" && iex --sname mike -S mix
  :observer.start() # optional
  Hangman.Text.Client.start()
  ```

  #### PowerShell

  ```
  cd hangman_text_client
  $Env:MIX_ENV = "dev"; iex --sname mike -S mix
  :observer.start() # optional
  Hangman.Text.Client.start()
  ```

  ### *LONG NAMES WITHOUT USING RELEASES*

  Start the engine using a long name:

  ```
  cd hangman_engine
  iex --name hangman_engine@rays.supratech.ca -S mix
  :observer.start() # optional
  ```

  Start a game from a different node with a long name:

  #### Commmand shell

  ```
  cd hangman_text_client
  set "MIX_ENV=prod" && iex --name mike@rays.supratech.ca -S mix
  :observer.start() # optional
  Hangman.Text.Client.start()
  ```

  #### PowerShell

  ```
  cd hangman_text_client
  $Env:MIX_ENV = "prod"; iex --name mike@rays.supratech.ca -S mix
  :observer.start() # optional
  Hangman.Text.Client.start()
  ```

  ### *SHORT NAMES USING RELEASES*

  Start the engine using a short name:

  ```
  cd hangman_engine
  iex --sname hangman_engine --cookie fortune -S mix
  :observer.start() # optional
  ```

  Start a game from a different node with a short name:

  #### Command shell

  ```
  cd hangman_text_client
  set RELEASE_NODE=mike@rays
  "_build/dev/rel/hangman_text_client/bin/hangman_text_client" start_iex
  :observer.start() # optional
  Hangman.Text.Client.start()
  ```

  #### PowerShell

  ```
  cd hangman_text_client
  $Env:RELEASE_NODE = "mike@rays"
  _build/dev/rel/hangman_text_client/bin/hangman_text_client start_iex
  :observer.start() # optional
  Hangman.Text.Client.start()
  ```

  ### *LONG NAMES USING RELEASES*

  Start the engine using a long name:

  ```
  cd hangman_engine
  iex --name hangman_engine@rays.supratech.ca --cookie fortune -S mix
  :observer.start() # optional
  ```

  Start a game from a different node with a long name:

  #### Commmand shell

  ```
  cd hangman_text_client
  set RELEASE_NODE=mike@rays.supratech.ca
  "_build/prod/rel/hangman_text_client/bin/hangman_text_client" start_iex
  :observer.start() # optional
  Hangman.Text.Client.start()
  ```

  #### PowerShell

  ```
  cd hangman_text_client
  $Env:RELEASE_NODE = "mike@rays.supratech.ca"
  _build/prod/rel/hangman_text_client/bin/hangman_text_client start_iex
  :observer.start() # optional
  Hangman.Text.Client.start()
  ```
  """
  @spec start(Game.name()) :: no_return
  def start(game_name \\ Hangman.Game.random_name()) do
    Engine.new_game(game_name) |> State.new() |> Player.play()
  end

  @doc ~S"""
  Returns the hangman engine node.

  ## Examples

      iex> alias Hangman.Text.Client
      iex> engine_node = Client.engine_node()
      iex> "#{engine_node}" =~ "hangman_engine@"
      true
  """
  @spec engine_node :: node
  def engine_node, do: get_env(:engine_node)
end
