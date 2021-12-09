defmodule AdventOfCode.Day05 do
  @spec problem1 :: non_neg_integer
  def problem1 do
    input()
    |> Enum.reduce(%{}, fn
      [x, y1, x, y2], grid ->
        Enum.reduce(y1..y2, grid, fn y, grid ->
          Map.update(grid, {x, y}, 1, &(&1 + 1))
        end)

      [x1, y, x2, y], grid ->
        Enum.reduce(x1..x2, grid, fn x, grid ->
          Map.update(grid, {x, y}, 1, &(&1 + 1))
        end)

      _line, grid ->
        grid
    end)
    |> Enum.count(fn {_, v} -> v > 1 end)
  end

  @spec problem2 :: non_neg_integer
  def problem2 do
    input()
    |> Enum.reduce(%{}, fn
      [x, y1, x, y2], grid -> sum_grid(Stream.cycle([x]), y1..y2, grid)
      [x1, y, x2, y], grid -> sum_grid(x1..x2, Stream.cycle([y]), grid)
      [x1, y1, x2, y2], grid -> sum_grid(x1..x2, y1..y2, grid)
    end)
    |> Enum.count(fn {_, v} -> v > 1 end)
  end

  defp input() do
    input =
      File.read!("data/05/input")
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split([",", " -> "])
        |> Enum.map(&String.to_integer/1)
      end)

    input
  end

  defp sum_grid(xs, ys, grid) do
    Enum.reduce(Enum.zip(xs, ys), grid, fn point, grid ->
      Map.update(grid, point, 1, &(&1 + 1))
    end)
  end
end
