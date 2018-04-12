defmodule Hangman.TextClient do
  @moduledoc """
  Text client for the Hangman game.
  """

  alias __MODULE__.Interact

  @doc """
  Starts a Hangman game.

  App `:hangman_engine` must run in node `:hangman@<hostname>`...
  - `cd hangman_engine`
  - `iex --sname hangman -S mix`
  - `:observer.start()`

  Each client must run in a different node...
  - `cd hangman_text_client`
  - `iex --sname c[lient]<n> -S mix`
  - `Hangman.TextClient.start("Mike")`
  """
  defdelegate start(), to: Interact
  defdelegate start(player), to: Interact
end
