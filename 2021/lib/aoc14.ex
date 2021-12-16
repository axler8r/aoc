defmodule AdventOfCode.Day14 do
  @spec problem1 :: number
  def problem1() do
    input() |> parse() |> do_problem1()
  end

  @spec problem2 :: number
  def problem2() do
    input() |> parse() |> do_problem2()
  end

  defp input() do
    input =
      File.read!("data/14/input")
      |> String.split("\n\n", trim: true)

    input
  end

  defp parse([template, pairs]) do
    {
      template,
      pairs
      |> String.split("\n", trim: true)
      |> Enum.map(&(String.split(&1, " -> ", trim: true) |> List.to_tuple()))
      |> Map.new()
    }
  end

  defp do_problem1({polymar, pairs}), do: step(polymar, count(polymar), pairs, 10)
  defp do_problem2({polymar, pairs}), do: step(polymar, count(polymar), pairs, 40)

  defp step(polymar, pairs_count, _, 0) do
    count_chars(pairs_count, polymar) |> subtract_quantity()
  end

  defp step(polymar, pairs_count, pairs, n) do
    step(polymar, update_count(pairs_count, pairs), pairs, n - 1)
  end

  defp subtract_quantity(char_counts) do
    char_counts |> Map.values() |> Enum.min_max() |> then(fn {min, max} -> max - min end)
  end

  defp update_count(pairs_count, pairs) do
    pairs_count
    |> Enum.reduce(%{}, fn {pair, count}, acc ->
      [first, last] = String.graphemes(pair)

      Map.update(acc, first <> Map.get(pairs, pair), count, fn value -> value + count end)
      |> Map.update(Map.get(pairs, pair) <> last, count, fn value -> value + count end)
    end)
  end

  defp count(polymar) do
    polymar
    |> String.graphemes()
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(&Enum.join/1)
    |> Enum.frequencies()
  end

  defp count_chars(pairs_count, polymar) do
    Enum.reduce(
      pairs_count,
      %{
        (String.graphemes(polymar)
         |> Enum.at(-1)) => 1
      },
      fn {pair, count}, acc ->
        Map.update(
          acc,
          String.graphemes(pair)
          |> Enum.at(0),
          count,
          fn v -> v + count end
        )
      end
    )
  end
end
