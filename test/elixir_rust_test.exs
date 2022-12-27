defmodule ElixirRustTest do
  use ExUnit.Case
  doctest ElixirRust

  test "greets the world" do
    assert ElixirRust.hello() == :world
  end
end
