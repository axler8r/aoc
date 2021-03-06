defmodule AdventOfCode.Day06 do
  @spec problem1 :: number
  def problem1 do
    1..80
    |> Enum.reduce(input(), fn _, acc -> next(acc) end)
    |> Map.values()
    |> Enum.sum()
  end

  @spec problem2 :: number
  def problem2 do
    1..256
    |> Enum.reduce(input(), fn _, acc -> next(acc) end)
    |> Map.values()
    |> Enum.sum()
  end

  defp input() do
    seed = for i <- 0..8, into: %{}, do: {i, 0}

    input =
      File.read!("data/06/input")
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies()
      |> Map.merge(seed, fn _, a, _ -> a end)

    input
  end

  defp next(%{0 => next} = population) do
    1..8
    |> Map.new(&{&1 - 1, population[&1]})
    |> Map.merge(%{6 => next, 8 => next}, fn _, v1, v2 -> v1 + v2 end)
  end
end
