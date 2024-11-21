defmodule Hangman.Text.Client.Message.EnsureEngineStarted do
  alias IO.ANSI.Plus, as: ANSI

  @spec message(node) :: ANSI.ansilist()
  def message(node) do
    [
      :light_yellow,
      "Ensure Hangman Engine is started on node ",
      :light_white,
      "#{inspect(node)}",
      :light_yellow,
      "."
    ]
  end
end
