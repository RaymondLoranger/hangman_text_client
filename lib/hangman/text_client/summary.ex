defmodule Hangman.TextClient.Summary do
  # @moduledoc """
  # Displays a summary of the Hangman game.
  # """
  @moduledoc false

  alias Hangman.TextClient.State

  @spec display(State.t()) :: State.t()
  def display(%State{tally: tally} = state) do
    IO.puts("""

    Word so far:  #{Enum.join(tally.letters, " ")}
    Guesses left: #{tally.turns_left}
    """)

    state
  end
end
