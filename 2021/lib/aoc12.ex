defmodule AdventOfCode.Day12 do
  def dfs(graph, start, finish), do: dfs(graph, start, finish, [start])

  defp dfs(_graph, vertex, vertex, _visited), do: 1

  defp dfs(graph, vertex, finish, visited) do
    (graph[vertex] -- visited)
    |> Enum.reduce(0, fn vertex, acc ->
      visited = if small?(vertex), do: [vertex | visited], else: visited

      acc + dfs(graph, vertex, finish, visited)
    end)
  end

  def dfs2(graph, start, finish), do: dfs2(graph, start, finish, %{start => :inf})

  defp dfs2(_graph, vertex, vertex, _visited), do: 1

  defp dfs2(graph, vertex, finish, visited) do
    (graph[vertex] -- keys(visited))
    |> Enum.reduce(0, fn vertex, acc ->
      visited = if small?(vertex), do: Map.update(visited, vertex, 1, &(&1 + 1)), else: visited

      acc + dfs2(graph, vertex, finish, visited)
    end)
  end

  defp keys(map) do
    if Enum.any?(map, fn {_, v} -> v == 2 end) do
      # there is already some vertex visited twice
      Map.keys(map)
    else
      for {k, v} <- map, v > 1, do: k
    end
  end

  defp small?(<<c>> <> _), do: c in ?a..?z




  def problem1 do
    :ok
  end

  def problem2 do
    :ok
  end

  def input do
    input =
      File.read!("data/12/input")
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, "-"))

    input
  end

  def graph do
    graph =
      Enum.reduce(input(), %{}, fn ([a, b], acc) ->
        acc
        |> Map.update(a, [b], &[b | &1])
        |> Map.update(b, [a], &[a | &1])
      end)

    graph
  end
end
