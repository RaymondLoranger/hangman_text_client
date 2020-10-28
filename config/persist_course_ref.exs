import Config

config :hangman_text_client,
  course_ref:
    """
    Based on the course [Elixir for Programmers](https://codestool.
    coding-gnome.com/courses/elixir-for-programmers) by Dave Thomas.
    """
    |> String.replace("\n", "")
