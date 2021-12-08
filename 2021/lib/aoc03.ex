defmodule AdventOfCode.Day03 do
  @spec input :: list
  def input do
    input =
      File.stream!("data/03/input")
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.to_charlist/1)

    input
  end

  @spec count(any) :: any
  def count(list) do
    Enum.reduce(list, List.duplicate(0, 12), fn input, acc ->
      for {value, counter} <- Enum.zip(input, acc) do
        case value do
          ?1 -> counter + 1
          ?0 -> counter
        end
      end
    end)
  end

  @spec problem1 :: number
  def problem1 do
    half = div(length(input()), 2)

    {γ, ε} =
      input()
      |> count()
      |> Enum.reduce({0, 0}, fn elem, {a, b} ->
        if elem > half do
          {a * 2 + 1, b * 2}
        else
          {a * 2, b * 2 + 1}
        end
      end)

    γ * ε
  end

  def problem2 do
    co2 = List.to_integer(do_reduce(input(), &</2), 2)
    o2 = List.to_integer(do_reduce(input(), &>/2), 2)

    co2 * o2
  end

  defp do_reduce(list, cb), do: do_reduce(list, 0, cb)

  defp do_reduce([elem], _, _), do: elem

  defp do_reduce(list, at, cb) do
    counts = count(list)

    half = div(length(list), 2)
    count = Enum.at(counts, at)

    bit =
      cond do
        count == half and cb.(count + 1, half) -> ?1
        count != half and cb.(count, half) -> ?1
        true -> ?0
      end

    do_reduce(Enum.filter(list, &(Enum.at(&1, at) == bit)), at + 1, cb)
  end
end
