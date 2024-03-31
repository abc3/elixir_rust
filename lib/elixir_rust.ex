defmodule ElixirRust do
  @moduledoc """
  Documentation for `ElixirRust`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ElixirRust.hello()
      :world

  """
  def hello do
    :world
  end

  def rand_string() do
    Base.encode64(:crypto.strong_rand_bytes(12))
  end  

  def echo(m), do: m
end
