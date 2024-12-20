defmodule Hangman.Text.Client.Message.EngineNotStarted do
  alias IO.ANSI.Plus, as: ANSI

  @spec message(node) :: ANSI.ansilist()
  def message(node) do
    [
      :light_yellow,
      "Hangman Engine not started on node ",
      :light_white,
      "#{inspect(node)}",
      :light_yellow,
      "."
    ]
  end
end
