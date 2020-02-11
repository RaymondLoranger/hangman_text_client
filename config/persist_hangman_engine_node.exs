use Mix.Config

# Here {:ok, 'rays'}...
{:ok, hostname} = :inet.gethostname()

# Here :hangman_engine@rays...
hangman_engine_node = List.to_atom('hangman_engine@' ++ hostname)

config :hangman_text_client, hangman_engine_node: hangman_engine_node
