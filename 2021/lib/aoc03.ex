defmodule AdventOfCode.Day03 do
  @spec problem1 :: number
  def problem1 do
    {input, _} = input()

    half = div(length(input), 2)

    {γ, ε} =
      input
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

  @spec problem2 :: integer
  def problem2 do
    {_, input} = input()

    o2(input) * co2(input)
  end

  defp o2(numbers) do
    do_extract(numbers, 0, fn zero_count, one_count ->
      if one_count >= zero_count, do: ?1, else: ?0
    end)
  end

  defp co2(numbers) do
    do_extract(numbers, 0, fn zero_count, one_count ->
      if zero_count <= one_count, do: ?0, else: ?1
    end)
  end

  defp input, do: {input1(), input2()}

  defp input1 do
    input =
      File.stream!("data/03/input")
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.to_charlist/1)

    input
  end

  defp input2() do
    input =
      File.read!("data/03/input")
      |> String.split("\n", trim: true)
      |> Enum.map(&(&1 |> String.to_charlist() |> List.to_tuple()))

    input
  end

  defp count(list) do
    Enum.reduce(list, List.duplicate(0, 12), fn input, acc ->
      for {value, counter} <- Enum.zip(input, acc) do
        case value do
          ?1 -> counter + 1
          ?0 -> counter
        end
      end
    end)
  end

  defp do_extract([number], _pos, _fun) do
    number
    |> Tuple.to_list()
    |> List.to_integer(2)
  end

  defp do_extract(numbers, pos, fun) do
    zero_count = Enum.count(numbers, &(elem(&1, pos) == ?0))
    one_count = length(numbers) - zero_count
    to_keep = fun.(zero_count, one_count)
    numbers = Enum.filter(numbers, &(elem(&1, pos) == to_keep))
    do_extract(numbers, pos + 1, fun)
  end
end
