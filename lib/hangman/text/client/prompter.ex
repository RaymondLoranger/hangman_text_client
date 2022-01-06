defmodule Hangman.Text.Client.Prompter do
  @moduledoc """
  Prompts a player for a move.
  """

  alias Hangman.Text.Client.{Player, State}

  @doc """
  Displays a `message` and accepts a player's move.
  """
  @spec accept_move(State.t(), String.t()) :: State.t() | no_return
  def accept_move(state, message) do
    IO.puts(message)
    accept_move(state)
  end

  @doc """
  Accepts a player's move.
  """
  @spec accept_move(State.t()) :: State.t() | no_return
  def accept_move(%State{} = state) do
    "Your guess (or stop): "
    |> IO.gets()
    |> check_input(state)
  end

  ## Private functions

  # "Player's input"
  @typep input :: String.t() | {:error, atom} | :eof

  @spec check_input(input, State.t()) :: State.t() | no_return
  defp check_input({:error, reason}, state),
    do: Player.end_game(state, "Game ended: #{inspect(reason)}.")

  defp check_input(:eof, state),
    do: Player.end_game(state, "Looks like you gave up somehow.")

  defp check_input(input, state) do
    case String.trim(input) do
      "stop" ->
        Player.end_game(state, "Looks like you gave up.")

      <<char>> = guess when char in ?a..?z ->
        put_in(state.guess, guess)

      _bad_input ->
        accept_move(state, "Please enter a single lowercase letter.")
    end
  end
end
