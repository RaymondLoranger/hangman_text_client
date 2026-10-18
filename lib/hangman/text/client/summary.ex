defmodule Hangman.Text.Client.Summary do
  @moduledoc """
  Displays a summary of the game.
  """

  alias IO.ANSI.Plus, as: ANSI
  alias Hangman.Text.Client.State

  @sp " "

  @doc """
  Displays a summary of the game.
  """
  @spec display(State.t()) :: State.t()
  def display(state) do
    message(state) |> ANSI.puts()
    state
  end

  ## Private functions

  # Word so far:  _ a n a g e d
  # Guesses left: 2
  # Letters used: a d e f g n r t u y

  @spec message(State.t()) :: ANSI.ansilist()
  defp message(%State{tally: %{turns_left: 1}} = state) do
    # Message highlighted to signal last guess...
    message(state, :light_yellow, :fuchsia)
  end

  defp message(state) do
    message(state, :light_white, :light_cyan)
  end

  @spec message(State.t(), ANSI.ansicode(), ANSI.ansicode()) :: ANSI.ansilist()
  defp message(%State{tally: tally}, label_color, value_color) do
    [
      :reset,
      label_color,
      "\nWord so far:  ",
      value_color,
      "#{Enum.join(tally.letters, @sp)}",
      label_color,
      "\nGuesses left: ",
      value_color,
      "#{tally.turns_left}",
      label_color,
      "\nLetters used: ",
      value_color,
      "#{Enum.join(tally.guesses, @sp)}\n"
    ]
  end
end
