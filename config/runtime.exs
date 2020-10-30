import Config

engine_node =
  if config_env() == :prod do
    # long name -- 'hosts' file must map host name to IP address
    'hangman_engine@rays.supratech.ca'
  else
    {:ok, hostname} = :inet.gethostname()
    # short name
    'hangman_engine@' ++ hostname
  end

config :hangman_text_client, engine_node: List.to_atom(engine_node)
