:timer.sleep(2_500)

Benchee.run(%{
  "elixir echo" => fn ->
    "some_string" = ElixirRust.echo("some_string")
  end,
  "port echo" => fn ->
    "some_string" = ElixirRust.Port.echo("some_string")
  end,
  "rustler echo" => fn ->
    "some_string" = ElixirRust.Rustler.echo("some_string")
  end,
  "docker echo" => fn ->
    "some_string" = ElixirRust.DockerPort.echo("some_string")
  end,
  "docker tcp socket" => fn ->
    "some_string" = ElixirRust.SocketHandler.echo("some_string")
  end
})
