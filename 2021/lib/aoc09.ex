defmodule AdventOfCode.Day09 do
  @spec problem1 :: number
  def problem1 do
    {width, height} = _shape = Nx.shape(input())

    padded = Nx.pad(input(), 99, [{0, 0, 0}, {1, 1, 0}])
    shifted = Nx.slice_axis(padded, 0, height, :x)
    x1 = Nx.less(input(), shifted)
    shifted = Nx.slice_axis(padded, 2, height, :x)
    x2 = Nx.less(input(), shifted)
    x = Nx.logical_and(x1, x2)

    padded = Nx.pad(input(), 99, [{1, 1, 0}, {0, 0, 0}])
    shifted = Nx.slice_axis(padded, 0, width, :y)
    y1 = Nx.less(input(), shifted)
    shifted = Nx.slice_axis(padded, 2, width, :y)
    y2 = Nx.less(input(), shifted)
    y = Nx.logical_and(y1, y2)

    minimas = Nx.logical_and(x, y)

    input()
    |> Nx.multiply(minimas)
    |> Nx.sum()
    |> Nx.to_number()
  end

  @spec problem2 :: any
  def problem2 do
    {width, _height} = shape = Nx.shape(input())

    input()
    |> Nx.equal(10)
    |> Nx.logical_not()
    |> Nx.select(Nx.iota(shape), 9999)
    |> Nx.to_flat_list()
    |> Enum.reject(&(&1 == 9999))
    |> Enum.map(fn point -> {div(point, width), rem(point, width)} end)
    |> Enum.reduce([], fn {y, x} = point, basins ->
      basin_left = Enum.find_index(basins, &({y, x - 1} in &1))
      basin_up = Enum.find_index(basins, &({y - 1, x} in &1))

      case {basin_left, basin_up} do
        {nil, nil} ->
          [MapSet.new([point]) | basins]

        {idx, nil} ->
          List.update_at(basins, idx, &MapSet.put(&1, point))

        {nil, idx} ->
          List.update_at(basins, idx, &MapSet.put(&1, point))

        {idx, idx} ->
          List.update_at(basins, idx, &MapSet.put(&1, point))

        {idx1, idx2} ->
          {old, basins} = List.pop_at(basins, max(idx1, idx2))

          List.update_at(basins, min(idx1, idx2), &(&1 |> MapSet.union(old) |> MapSet.put(point)))
      end
    end)
    |> Enum.map(&MapSet.size/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.reduce(&*/2)
  end

  defp input do
    input =
      File.read!("data/09/input")
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_charlist(String.trim(&1)))
      |> Nx.tensor(names: [:y, :x])
      |> Nx.subtract(?0)
      |> Nx.add(1)

    input
  end
end
