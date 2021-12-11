defmodule AdventOfCode.Day10 do
  @block %{"(" => ")", "[" => "]", "{" => "}", "<" => ">"}
  @error %{")" => 3, "]" => 57, "}" => 1197, ">" => 25137}
  @autocorrect %{")" => 1, "]" => 2, "}" => 3, ">" => 4}

  @spec problem1 :: number
  def problem1 do
    input()
    |> Enum.map(&parse/1)
    |> Enum.filter(&(elem(&1, 0) == :error))
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.sum()
  end

  @spec problem2 :: number
  def problem2 do
    results =
      input()
      |> Enum.map(&parse/1)
      |> Enum.filter(&(elem(&1, 0) == :ok))
      |> Enum.map(fn {_, v} -> v end)
      |> Enum.sort()

    middle = results |> length() |> div(2)
    Enum.at(results, middle)
  end

  defp input do
    input =
      File.read!("data/10/input")
      |> String.split("\n", trim: true)
      |> Enum.map(&String.codepoints/1)

    input
  end

  defp parse(line, open \\ [])

  defp parse([head | tail], open) when head in ["(", "[", "{", "<"] do
    parse(tail, [head | open])
  end

  defp parse([head | tail], [open_head | open_tail]) do
    if head == @block[open_head] do
      parse(tail, open_tail)
    else
      {:error, @error[head]}
    end
  end

  defp parse(_, open) do
    score =
      Enum.reduce(open, 0, fn char, acc ->
        acc * 5 + @autocorrect[@block[char]]
      end)

    {:ok, score}
  end
end
