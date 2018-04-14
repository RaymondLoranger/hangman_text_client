defmodule Hangman.TextClient.Prompter do
  # @moduledoc """
  # Prompts a Hangman game player.
  # """
  @moduledoc false

  alias Hangman.TextClient.{Player, State}

  @type input :: String.t() | {:error, atom} | :eof

  @spec accept_move(State.t(), String.t()) :: State.t() | no_return
  def accept_move(%State{player_name: player_name} = state, msg \\ "") do
    unless msg == "", do: IO.puts(msg)
    "#{player_name}, your guess (or stop): " |> IO.gets() |> check_input(state)
  end

  ## Private functions

  @spec check_input(input, State.t()) :: State.t() | no_return
  defp check_input({:error, reason}, state),
    do: Player.end_game(state, "Game ended: #{reason}")

  defp check_input(:eof, state),
    do: Player.end_game(state, "Looks like you gave up (eof).")

  defp check_input(input, state) do
    case String.trim(input) do
      "stop" -> Player.end_game(state, "Looks like you gave up.")
      <<char>> = guess when char in ?a..?z -> put_in(state.guess, guess)
      _bad -> accept_move(state, "Please enter a single lowercase letter.")
    end
  end
end
