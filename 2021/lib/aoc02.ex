defmodule AdventOfCode.Day02 do
  def problem1 do
    {x, y} = File.read!("data/02/input")
    |> extract_position()

    x * y
  end

  defp extract_position(data) do
    do_extract_position(data, {0, 0})
  end

  defp do_extract_position(<<>>, acc) do
    acc
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
