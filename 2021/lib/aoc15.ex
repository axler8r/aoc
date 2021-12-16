defmodule AdventOfCode.Day15 do
  @spec problem1 :: non_neg_integer()
  def problem1() do
    map = parse(input())
    solve(map)
  end

  @spec problem2 :: non_neg_integer()
  def problem2() do
    grid = parse(input())
    {max_x, max_y} = find_lower_right(grid)
    width = max_x + 1
    height = max_y + 1

    grid =
      grid
      |> Enum.reduce(grid, fn {{x, y}, risk}, grid ->
        Enum.reduce(1..4, grid, fn index, grid ->
          Map.put(grid, {x + index * width, y}, increment_risk(risk, index))
        end)
      end)

    grid =
      grid
      |> Enum.reduce(grid, fn {{x, y}, risk}, grid ->
        Enum.reduce(1..4, grid, fn index, grid ->
          Map.put(grid, {x, y + index * height}, increment_risk(risk, index))
        end)
      end)

    solve(grid)
  end

  defp input do
    input =
      File.read!("data/15/input")
      |> String.split("\n", trim: true)

    input
  end

  defp increment_risk(risk, increment) do
    risk = risk + increment
    if risk > 9, do: risk - 9, else: risk
  end

  defp solve(map) do
    goal = find_lower_right(map)
    start = {0, 0}
    q = :gb_sets.singleton({0, start})
    best = :infinity
    seen = MapSet.new()
    solve(q, map, best, goal, seen)
  end

  defp find_lower_right(grid) do
    {{max_x, _}, _} = Enum.max_by(grid, fn {{x, _}, _} -> x end)
    {{_, max_y}, _} = Enum.max_by(grid, fn {{_, y}, _} -> y end)
    {max_x, max_y}
  end

  defp solve(q, grid, best, goal, seen) do
    case :gb_sets.is_empty(q) do
      true ->
        best

      false ->
        {element, q} = :gb_sets.take_smallest(q)

        case element do
          {risk, _} when risk >= best ->
            solve(q, grid, best, goal, seen)

          {risk, position} ->
            seen = MapSet.put(seen, position)

            case position do
              ^goal ->
                solve(q, grid, risk, goal, seen)

              _ ->
                q =
                  neighbors(grid, position)
                  |> Enum.reduce(q, fn pos, q ->
                    case MapSet.member?(seen, pos) do
                      true ->
                        q

                      false ->
                        element = {risk + Map.fetch!(grid, pos), pos}
                        :gb_sets.add(element, q)
                    end
                  end)

                solve(q, grid, best, goal, seen)
            end
        end
    end
  end

  defp neighbors(map, {row, col}) do
    [{row - 1, col}, {row, col - 1}, {row, col + 1}, {row + 1, col}]
    |> Enum.filter(&Map.has_key?(map, &1))
  end

  defp parse(input) do
    Enum.map(input, fn line ->
      String.to_charlist(line)
      |> Enum.map(&(&1 - ?0))
    end)
    |> Enum.with_index()
    |> Enum.flat_map(fn {list, row} ->
      Enum.with_index(list)
      |> Enum.map(fn {h, col} -> {{row, col}, h} end)
    end)
    |> Map.new()
  end
end
