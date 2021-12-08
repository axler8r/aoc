defmodule AdventOfCode.Day08 do
  def input do
    input =
      File.stream!("data/08/input")
      |> Stream.map(fn line ->
        line
        |> String.split(" | ")
        |> Enum.map(fn part ->
          part
          |> String.trim()
          |> String.split(" ")
          |> Enum.map(fn disp ->
            disp
            |> String.to_charlist()
            |> Enum.sort()
            |> List.to_string()
          end)
        end)
        |> List.to_tuple()
      end)

    input
  end

  @spec problem1 :: number
  def problem1 do
    input()
    |> Enum.map(fn {_, output} ->
      Enum.count(output, &(byte_size(&1) in [2, 3, 4, 7]))
    end)
    |> Enum.sum()
  end

  @spec problem2 :: number
  def problem2 do
    input()
    |> Enum.map(fn {input, output} ->
      input
      |> Enum.sort_by(&byte_size/1)
      |> Enum.map(&MapSet.new(String.to_charlist(&1)))
      |> List.to_tuple()
      |> deduce()
      |> decode(output)
    end)
    |> Enum.sum()
  end

  def a --- b do
    MapSet.difference(a, b)
  end

  def a +++ b do
    MapSet.union(a, b)
  end

  def a <~> b do
    MapSet.intersection(a, b)
  end

  def a <|> b do
    (a +++ b) --- (a <~> b)
  end

  #            1.   7.    4. 2|3|5. 2|3|5. 2|3|5.  6|9|0.  6|9|0.  6|9|0.       8.
  defp deduce({cf, acf, bcdf, _, _, _, abdefg, abcdfg, abcefg, abcdefg}) do
    a = acf --- cf
    eg = abcdefg --- (acf +++ bcdf)
    bd = bcdf --- cf
    abfg = abdefg <|> abcdfg <|> abcefg
    b = abfg <~> bd
    f = abfg <~> cf
    g = abfg --- (a +++ b +++ f)
    d = bd --- b
    c = cf --- f
    e = eg --- g

    {a, b, c, d, e, f, g} =
      [a, b, c, d, e, f, g]
      |> Enum.map(&extract/1)
      |> List.to_tuple()

    [
      # 0
      [a, b, c, e, f, g],
      # 1
      [c, f],
      # 2
      [a, c, d, e, g],
      # 3
      [a, c, d, f, g],
      # 4
      [b, c, d, f],
      # 5
      [a, b, d, f, g],
      # 6
      [a, b, d, e, f, g],
      # 7
      [a, c, f],
      # 8
      [a, b, c, d, e, f, g],
      # 9
      [a, b, c, d, f, g]
    ]
    |> Enum.map(&List.to_string(Enum.sort(&1)))
    |> Enum.with_index()
    |> Map.new()
  end

  defp extract(a) do
    [v] = MapSet.to_list(a)

    v
  end

  defp decode(matches, output) do
    output
    |> Enum.map(&matches[&1])
    |> Integer.undigits()
  end
end
