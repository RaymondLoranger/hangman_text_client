defmodule Hangman.TextClient.Summary do
  # @moduledoc """
  # Displays a summary of the Hangman game.
  # """
  @moduledoc false

  alias Hangman.TextClient.State

  @spec display(State.t()) :: State.t()
  def display(%State{tally: tally} = state) do
    # IO.puts([
    #   "\n",
    #   "Word so far:  #{Enum.join(tally.letters, " ")}\n",
    #   "Guesses left: #{tally.turns_left}\n"
    # ])
    IO.puts("""
    Word so far:  #{Enum.join(tally.letters, " ")}
    Guesses left: #{tally.turns_left}
    """)

    # IO.puts([
    #   "\n",
    #   "Word so far:  ",
    #   io_list(tally.letters),
    #   "\n",
    #   "Guesses left: #{tally.turns_left}"
    # ])

    state
  end

  ## Private functions

  # @spec io_list([String.codepoint()]) :: IO.chardata()
  # defp io_list(letters), do: letters |> Enum.reduce([], &[&2 | [&1, " "]])
end
