use Mix.Config

# Here {:ok, 'rays'}...
{:ok, hostname} = :inet.gethostname()

# Here :hangman@rays...
hangman_node = List.to_atom('hangman@' ++ hostname)

config :hangman_text_client, hangman_node: hangman_node
