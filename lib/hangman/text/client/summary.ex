defmodule Hangman.Text.Client.Summary do
  @moduledoc """
  Displays a summary of the game.
  """

  alias Hangman.Text.Client.State

  @doc """
  Displays a summary of the game.
  """
  @spec display(State.t()) :: State.t()
  def display(%State{tally: tally} = state) do
    IO.puts("""

    Word so far:  #{Enum.join(tally.letters, " ")}
    Used letters: #{Enum.join(tally.guesses, " ")}
    Guesses left: #{tally.turns_left}
    """)

    state
  end
end
