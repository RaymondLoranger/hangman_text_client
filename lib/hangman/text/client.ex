# ┌──────────────────────────────────────────────────────────────┐
# │ Based on the course "Elixir for Programmers" by Dave Thomas. │
# └──────────────────────────────────────────────────────────────┘
defmodule Hangman.Text.Client do
  use PersistConfig

  @course_ref Application.get_env(@app, :course_ref)

  @moduledoc """
  Text client for the _Hangman Game_.

  ##### #{@course_ref}
  """

  alias __MODULE__.Interact

  @doc """
  Starts a _Hangman Game_.

  App `:hangman_engine` must run in node `:hangman_engine@<hostname>`:
  - `cd hangman_engine`
  - `iex --sname hangman_engine -S mix`
  - `:observer.start() # optional`

  Each client must run in a different node.
  For example, the n-th client may specify:
  - `cd hangman_text_client`
  - `iex --sname client_<n> -S mix`
  - `Hangman.Text.Client.start("Mike")`
  """
  @spec start(String.t()) :: no_return
  defdelegate start(player_name), to: Interact
end
