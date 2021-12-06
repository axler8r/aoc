defmodule Aoc001 do
  def problem_1 do
    {_, answer} = File.stream!("data/input")
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.to_integer/1)
      |> Enum.reduce({0, -1}, fn (c, {p, a} = _a) ->
        cond do
          c >= p -> {c, a + 1}
          true -> {c, a}
        end
      end)

    IO.puts(answer)
  end
end
