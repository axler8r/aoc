defmodule AdventOfCode.Day13 do
  import Enum

  @spec problem1 :: non_neg_integer
  def problem1(), do: input() |> do_problem1()
  @spec problem2 :: :ok
  def problem2(), do: input() |> do_problem2()

  defp do_problem1([points, ins]),
    do: fold(make_grid(points), at(ins, 0)) |> List.flatten() |> count(& &1)

  defp do_problem2([points, ins]),
    do: reduce(ins, make_grid(points), fn ins, acc -> fold(acc, ins) end) |> print()

  defp make_grid(points) do
    for y <- 0..max(map(points, fn [_x, y] -> y end)) do
      for x <- 0..max(map(points, fn [x, _y] -> x end)) do
        [x, y] in points
      end
    end
  end

  defp fold(grid, {:up, level}) do
    zip([grid |> take(level), grid |> take(-level) |> reverse()])
    |> map(fn {top, bottom} ->
      map(zip(top, bottom), fn {first, second} -> first or second end)
    end)
  end

  defp fold(grid, {:left, level}) do
    zip([grid |> map(&take(&1, level)), grid |> map(&(take(&1, -level) |> reverse()))])
    |> map(fn {x, y} -> map(zip(x, y), fn {a, b} -> a or b end) end)
  end

  defp input() do
    input =
      File.read!("data/13/input")
      |> parse()

    input
  end

  defp parse(data) do
    data
    |> String.split("\n\n", trim: true)
    |> then(fn [points, ins] -> [parse(points, :points), parse(ins, :ins)] end)
  end

  defp parse(points, :points) do
    points
    |> String.split("\n", trim: true)
    |> map(fn str -> str |> String.split(",")
    |> map(&String.to_integer/1) end)
  end

  defp parse(ins, :ins) do
    ins
    |> String.split("\n", trim: true)
    |> map(&String.split(&1, "=", trim: true))
    |> map(fn [direction, num] ->
      if String.contains?(direction, "x"),
        do: {:left, String.to_integer(num)},
        else: {:up, String.to_integer(num)}
    end)
  end

  defp print(grid) do
    grid
    |> map(&map(&1, fn i -> get_char(i) end))
    |> map(&join(&1, ""))
    |> join("\n")
    |> IO.puts()
  end

  defp get_char(true), do: "⬛"
  defp get_char(false), do: "  "
end
