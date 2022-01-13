defmodule Hangman.Text.Client.Summary do
  @moduledoc """
  Displays a summary of the game.
  """

  alias Hangman.Text.Client.State

  @emit? true
  @more :reset
  @one :light_yellow

  @doc """
  Displays a summary of the game.
  """
  @spec display(State.t()) :: State.t()
  def display(%State{tally: tally} = state) do
    [
      if(tally.turns_left == 1, do: @one, else: @more),
      """

      Word so far:  #{Enum.join(tally.letters, " ")}
      Guesses left: #{tally.turns_left}
      Letters used: #{Enum.join(tally.guesses, " ")}
      """
    ]
    |> IO.ANSI.format(@emit?)
    |> IO.puts()

    state
  end
end
