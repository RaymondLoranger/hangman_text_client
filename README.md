# Hangman Text Client

Text client for the _Hangman Game_.

##### Based on the course [Elixir for Programmers](https://codestool.coding-gnome.com/courses/elixir-for-programmers) by Dave Thomas.

## Usage

To play the _Hangman Game_, clone `hangman_engine` and compile it:

```
git clone https://github.com/RaymondLoranger/hangman_engine
cd hangman_engine
mix deps.get
mix compile
```

Then, clone `hangman_text_client` and compile it:

```
git clone https://github.com/RaymondLoranger/hangman_text_client
cd hangman_text_client
mix deps.get
mix compile
```

## Locally when local node is not alive

Start a game like so:

```
cd hangman_text_client
iex -S mix
:observer.start() # optional
Hangman.Text.Client.start()
```

## Remotely when local node is alive

App `:hangman_engine` must run on node `:hangman_engine@<hostname>` where
`<hostname>` is either the full host name if long names are used, or the first
part of the full host name if short names are used.

### Short names

Start the engine using a short name:

```
cd hangman_engine
iex --sname hangman_engine -S mix
:observer.start() # optional
```

Start a game from a different node with a short name:

```
cd hangman_text_client
set "MIX_ENV=dev" && iex --sname mike -S mix
Hangman.Text.Client.start()
```

### Long names

Start the engine using a long name:

```
cd hangman_engine
iex --name hangman_engine@rays.supratech.ca -S mix
:observer.start() # optional
```

Start a game from a different node with a long name:

```
cd hangman_text_client
set "MIX_ENV=prod" && iex --name mike@rays.supratech.ca -S mix
Hangman.Text.Client.start()
```

### Short names using releases

Start the engine using a short name:

```
cd hangman_engine
iex --sname hangman_engine --cookie fortune -S mix
:observer.start() # optional
```

Start a game from a different node with a short name:

```
cd hangman_text_client
set RELEASE_NODE=mike@rays
"_build/dev/rel/hangman_text_client/bin/hangman_text_client" start_iex
Hangman.Text.Client.start()
```

### Long names using releases

Start the engine using a long name:

```
cd hangman_engine
iex --name hangman_engine@rays.supratech.ca --cookie fortune -S mix
:observer.start() # optional
```

Start a game from a different node with a long name:

```
cd hangman_text_client
set RELEASE_NODE=mike@rays.supratech.ca
"_build/prod/rel/hangman_text_client/bin/hangman_text_client" start_iex
Hangman.Text.Client.start()
```
