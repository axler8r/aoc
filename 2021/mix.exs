defmodule AdventOfCode.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent_of_code,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application, do: []

  defp deps do
    [
      {:nx, github: "elixir-nx/nx", sparse: "nx"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false}
    ]
  end
end
