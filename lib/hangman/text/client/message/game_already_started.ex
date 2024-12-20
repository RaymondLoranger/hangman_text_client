defmodule Hangman.Text.Client.Message.GameAlreadyStarted do
  alias IO.ANSI.Plus, as: ANSI
  alias Hangman.Game

  @spec message(Game.name(), node) :: ANSI.ansilist()
  def message(name, node) do
    [
      :light_yellow,
      "Hangman Game ",
      :light_white,
      "#{name}",
      :light_yellow,
      " already started on engine node ",
      :light_white,
      "#{inspect(node)}",
      :light_yellow,
      "."
    ]
  end
end
