defmodule Hangman.Text.Client.Summary do
  @moduledoc """
  Displays a summary of the _Hangman Game_.
  """

  alias Hangman.Text.Client.State

  @spec display(State.t()) :: State.t()
  def display(%State{tally: tally} = state) do
    IO.puts("""
    \nWord so far:  #{Enum.join(tally.letters, " ")}
    Guesses left: #{tally.turns_left}
    """)

    state
  end
end
