defmodule AdventOfCode.Day17 do
  @spec problem1 :: number
  def problem1 do
    input()
    |> calc()
    |> solve1()
  end

  @spec problem2 :: non_neg_integer
  def problem2 do
    input()
    |> calc()
    |> solve2()
  end

  defp input do
    input =
      File.read!("data/17/input")
      |> String.trim_leading("target area: ")
      |> String.split(", ", trim: true)
      |> then(fn ["x=" <> xs, "y=" <> ys] ->
        {xs, _} = Code.eval_string(xs)
        {ys, _} = Code.eval_string(ys)
        {xs, ys}
      end)

    input
  end

  defp calc({xmin..xmax = xs, ymin..ymax = ys}) do
    dxmin = 1..xmin |> Enum.find(&(Enum.sum(1..&1) >= xmin))

    Enum.reduce(dxmin..xmax, [], fn dx, acc ->
      Enum.reduce(ymin..-ymin, acc, fn dy, acc ->
        {dx_h0, x, dy_h0} =
          if dy > 0 do
            dx_h1 = dx - dy * 2
            {max(dx_h1 - 1, 0), Enum.sum(max(dx_h1, 1)..dx), -dy - 1}
          else
            {dx, 0, dy}
          end

        Stream.iterate({{x, 0}, {dx_h0, dy_h0}}, fn {{x, y}, {dx, dy}} ->
          {{x + dx, y + dy}, {(dx > 0 && dx - 1) || ((dx < 0 && dx + 1) || dx), dy - 1}}
        end)
        |> Stream.drop_while(fn {{x, y}, {dx, _dy}} ->
          (x < xmin and dx > 0) or y > ymax
        end)
        |> Stream.take_while(fn {{x, y}, _} ->
          x in xs and y in ys
        end)
        |> Enum.any?()
        |> if(do: [dy | acc], else: acc)
      end)
    end)
  end

  defp solve1(data) do
    data
    |> Enum.max()
    |> then(fn h -> Enum.sum(1..h) end)
  end

  defp solve2(data) do
    length(data)
  end
end
