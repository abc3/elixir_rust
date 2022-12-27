defmodule ElixirRust.Rustler do
  use Rustler, otp_app: :elixir_rust, crate: "elixirrust_rustler"

  # When your NIF is loaded, it will override this function.
  def echo(_string), do: :erlang.nif_error(:nif_not_loaded)
end
