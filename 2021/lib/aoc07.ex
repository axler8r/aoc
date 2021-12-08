defmodule AdventOfCode.Day07 do
  def input do
    input =
      File.read!("data/07/input")
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    input
  end

  def problem1 do
    mean = Enum.at(Enum.sort(input()), div(length(input()), 2))

    input()
    |> Enum.map(&abs(&1 - mean))
    |> Enum.sum()
  end

  def problem2 do
    arith_sum = fn n -> div(n * n + n, 2) end

    max = Enum.max(input())

    0..max
    |> Enum.reduce(:infinity, fn n, acc ->
      sum =
        input()
        |> Enum.map(&arith_sum.(abs(&1 - n)))
        |> Enum.sum()

      if sum < acc, do: sum, else: acc
    end)
  end
end
