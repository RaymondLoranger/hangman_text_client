defmodule Hangman.Text.Client.Message.GameStarted do
  alias IO.ANSI.Plus, as: ANSI
  alias Hangman.Game

  @spec message(Game.name(), node, pid) :: ANSI.ansilist()
  def message(name, node, pid) do
    [
      :light_yellow,
      "Hangman Game ",
      :light_white,
      "#{name} (#{inspect(pid)})",
      :light_yellow,
      " started on engine node ",
      :light_white,
      "#{inspect(node)}",
      :light_yellow,
      "."
    ]
  end
end
