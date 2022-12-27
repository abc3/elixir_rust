# NIF for Elixir.ElixirRust.Rustler

## To build the NIF module:

- Your NIF will now build along with your project.

## To load the NIF:

```elixir
defmodule ElixirRust.Rustler do
    use Rustler, otp_app: :elixir_rust, crate: "elixirrust_rustler"

    # When your NIF is loaded, it will override this function.
    def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
end
```

## Examples

[This](https://github.com/hansihe/NifIo) is a complete example of a NIF written in Rust.
