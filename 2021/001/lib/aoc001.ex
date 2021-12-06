defmodule Aoc001 do
  def problem1 do
    {_, answer} = File.stream!("data/input")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce({0, -1}, fn (current, {previous, acc} = _acc) ->
      cond do
        current >= previous -> {current, acc + 1}
        true -> {current, acc}
      end
    end)

    IO.puts(answer)
  end

  def problem2 do
    {_, answer} = File.stream!("data/input")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.to_list()
    |> chunk([])
    |> Enum.reverse()
    |> Enum.map(&Enum.sum/1)
    |> Enum.reduce({0, -1}, fn (current, {previous, acc} = _acc) ->
      cond do
        current > previous -> {current, acc + 1}
        true -> {current, acc}
      end
    end)

    answer
  end

  defp chunk([a, b, c], acc) do
    [[a, b, c ] | acc]
  end

  defp chunk([a, b, c | rest] = _list, acc) do
    acc = [[a, b, c] | acc]
    chunk([b, c | rest], acc)
  end
end
