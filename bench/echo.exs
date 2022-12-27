Benchee.run(%{
  "port echo" => fn ->
    "some_string" = ElixirRust.Port.echo("some_string")
  end,
  "rustler echo" => fn ->
    "some_string" = ElixirRust.Rustler.echo("some_string")
  end,
})
