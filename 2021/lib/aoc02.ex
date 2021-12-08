defmodule AdventOfCode.Day02 do
  def input do
    input =
      File.stream!("data/02/input")
      |> Stream.map(fn input ->
        case String.trim(input) do
          "forward " <> n -> {:forward, String.to_integer(n)}
          "up " <> n -> {:up, String.to_integer(n)}
          "down " <> n -> {:down, String.to_integer(n)}
        end
      end)

    input
  end

  @spec problem1 :: number
  def problem1 do
    {h, d} =
      input()
      |> Enum.reduce({0, 0}, fn
        {:forward, n}, {h, d} -> {h + n, d}
        {:up, n}, {h, d} -> {h, d - n}
        {:down, n}, {h, d} -> {h, d + n}
      end)

    h * d
  end

  @spec problem2 :: number
  def problem2 do
    {h, d, _} =
      input()
      |> Enum.reduce({0, 0, 0}, fn
        {:forward, n}, {h, d, a} -> {h + n, d + a * n, a}
        {:up, n}, {h, d, a} -> {h, d, a - n}
        {:down, n}, {h, d, a} -> {h, d, a + n}
      end)

    h * d
  end
end
