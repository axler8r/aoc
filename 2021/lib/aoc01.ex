defmodule AdventOfCode.Day01 do
  @spec problem1 :: non_neg_integer
  def problem1 do
    answer =
      input()
      |> Stream.chunk_every(2, 1, :discard)
      |> Enum.count(fn [a, b] -> a < b end)

    answer
  end

  @spec problem2 :: non_neg_integer
  def problem2 do
    answer =
      input()
      |> Stream.chunk_every(4, 1, :discard)
      |> Enum.count(fn [a, _, _, b] -> a < b end)

    answer
  end

  defp input do
    input =
      File.stream!("data/01/input")
      |> Stream.map(&String.to_integer(String.trim(&1)))

    input
  end
end
