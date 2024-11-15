defmodule Hangman.Text.Client.Prompter do
  @moduledoc """
  Prompts a player for a move.
  """

  alias IO.ANSI.Plus, as: ANSI
  alias Hangman.Text.Client.{Player, State}

  @doc """
  Accepts a player's move.
  """
  @spec accept_move(State.t()) :: State.t() | no_return
  def accept_move(%State{} = state) do
    IO.gets("Your guess (or stop): ") |> check_input(state)
  end

  ## Private functions

  # "Player's input"
  @typep input :: String.t() | {:error, atom} | :eof

  @spec check_input(input, State.t()) :: State.t() | no_return
  # Type `^G` (Ctrl+G) then `h` then `i 1` and then `c 1`.
  defp check_input({:error, reason}, state) do
    Player.end_game(state, [:light_yellow, "Game ended: #{inspect(reason)}."])
  end

  # Should be `^D` (Ctrl+D) but it does not work.
  # See https://github.com/erlang/otp/issues/4414
  defp check_input(:eof, state) do
    Player.end_game(state, [:light_yellow, "Looks like you gave up somehow."])
  end

  defp check_input(input, state) do
    case String.trim(input) do
      "stop" ->
        Player.end_game(state, [:light_yellow, "Looks like you gave up."])

      <<byte>> = guess when byte in ?a..?z ->
        put_in(state.guess, guess)

      _bad_input ->
        ANSI.puts([:light_yellow, "Please enter a letter between a and z.\n"])
        accept_move(state)
    end
  end
end
