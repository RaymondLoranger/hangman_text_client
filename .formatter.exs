# except = ["config/persist.exs", "test/**/text*.exs"]
except = []
inputs = ["*.exs", "{config,lib,test}/**/*.{ex,exs}"]
wild = fn glob -> Path.wildcard(glob, match_dot: true) end
inputs = Enum.flat_map(inputs, &wild.(&1)) -- Enum.flat_map(except, &wild.(&1))

[
  inputs: inputs,
  line_length: 80
]
