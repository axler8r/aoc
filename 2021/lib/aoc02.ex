defmodule AdventOfCode.Day02 do
  def input do
    input =
      File.stream!("data/02/input")
      |> Stream.map(fn input ->
        case String.trim(input) do
          "forward " <> n -> {:forward, String.to_integer(n)}
          "up " <> n -> {:up, String.to_integer(n)}
          "down " <> n -> {:down, String.to_integer(n)}
        end
      end)

    input
  end

  @spec problem1 :: number
  def problem1 do
    {h, d} =
      input()
      |> Enum.reduce({0, 0}, fn
        {:forward, n}, {h, d} -> {h + n, d}
        {:up, n}, {h, d} -> {h, d - n}
        {:down, n}, {h, d} -> {h, d + n}
      end)

    h * d
  end

  defp do_extract_position("forward " <> <<p, 10, tail::binary>> = _data, {f, d} = _acc) do
    change = String.to_integer(<<p>>);
    do_extract_position(tail, {f + change, d})
  end

  defp do_extract_position("down " <> <<p, 10, tail::binary>> = _data, {f, d} = _acc) do
    change = String.to_integer(<<p>>);
    do_extract_position(tail, {f, d + change})
  end

  defp do_extract_position("up " <> <<p, 10, tail::binary>> = _data, {f, d} = _acc) do
    change = String.to_integer(<<p>>);
    do_extract_position(tail, {f, d - change})
  end
end
