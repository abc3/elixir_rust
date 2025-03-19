defmodule ElixirRust.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_rust,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ElixirRust.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler, "~> 0.36.1"},
      {:benchee, "~> 1.3.1", only: :dev},
      {:ranch, "~> 2.2.0"}
    ]
  end
end
