defmodule Hangman.Text.Client.Message.EngineNodeDown do
  alias IO.ANSI.Plus, as: ANSI

  @spec message(node) :: ANSI.ansilist()
  def message(node) do
    [
      :light_yellow,
      "Hangman Engine node ",
      :light_white,
      :italic,
      "#{inspect(node)}",
      :light_yellow,
      :not_italic,
      " is down."
    ]
  end
end
