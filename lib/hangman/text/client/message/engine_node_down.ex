defmodule Hangman.Text.Client.Message.EngineNodeDown do
  alias IO.ANSI.Plus, as: ANSI

  @spec message(node) :: ANSI.ansilist()
  def message(node) do
    [
      :light_yellow,
      "Hangman Engine node ",
      :light_white,
      "#{inspect(node)}",
      :light_yellow,
      " is down."
    ]
  end
end
