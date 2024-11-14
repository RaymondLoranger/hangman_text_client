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
  defp message(%State{tally: %{turns_left: 1} = tally}) do
    # Message highlighted to signal last guess...
    [
      :reset,
      :light_yellow,
      "\nWord so far:  ",
      :fuchsia,
      "#{Enum.join(tally.letters, @sp)}",
      :light_yellow,
      "\nGuesses left: ",
      :fuchsia,
      "1",
      :light_yellow,
      "\nLetters used: ",
      :fuchsia,
      "#{Enum.join(tally.guesses, @sp)}\n"
    ]
  end

  defp message(%State{tally: tally}) do
    [
      :reset,
      :light_white,
      "\nWord so far:  ",
      :light_cyan,
      "#{Enum.join(tally.letters, @sp)}",
      :light_white,
      "\nGuesses left: ",
      :light_cyan,
      "#{tally.turns_left}",
      :light_white,
      "\nLetters used: ",
      :light_cyan,
      "#{Enum.join(tally.guesses, @sp)}\n"
    ]
  end
end
