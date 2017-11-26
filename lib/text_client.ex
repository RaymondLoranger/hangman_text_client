defmodule TextClient do
  @moduledoc """
  Text client for the Hangman game.
  """

  alias TextClient.Interact

  @doc """
  Starts a Hangman game.
  """
  defdelegate start(), to: Interact
end
