defmodule AdventOfCode.Day10.Syntax do
  @spec parse(binary) :: :ok | {:corrupted, byte} | {:incomplete, [41 | 62 | 93 | 125]}
  def parse(line), do: parse(line, [])

  # Opening
  defp parse(<<?(, rest::binary>>, stack), do: parse(rest, [?) | stack])
  defp parse(<<?[, rest::binary>>, stack), do: parse(rest, [?] | stack])
  defp parse(<<?{, rest::binary>>, stack), do: parse(rest, [?} | stack])
  defp parse(<<?<, rest::binary>>, stack), do: parse(rest, [?> | stack])

  # Closing
  defp parse(<<char, rest::binary>>, [char | stack]), do: parse(rest, stack)

  # Base/error cases
  defp parse(<<char, _rest::binary>>, _stack), do: {:corrupted, char}
  defp parse(<<>>, []), do: :ok
  defp parse(<<>>, stack), do: {:incomplete, stack}
end

defmodule AdventOfCode.Day10 do
  import AdventOfCode.Day10.Syntax

  @spec problem1 :: number
  def problem1 do
    score = %{?) => 3, ?] => 57, ?} => 1197, ?> => 25137}

    Enum.sum(
      for line <- input(),
          {:corrupted, char} <- [parse(line)],
          do: score[char]
    )
  end

  @spec problem2 :: number
  def problem2 do
    score = %{?) => 1, ?] => 2, ?} => 3, ?> => 4}

    scores =
      Enum.sort(
        for line <- input(),
            {:incomplete, chars} <- [parse(line)],
            do: Enum.reduce(chars, 0, fn char, acc -> acc * 5 + score[char] end)
      )

    Enum.fetch!(scores, div(length(scores), 2))
  end

  defp input do
    input =
      File.read!("data/10/input")
      |> String.split("\n", trim: true)

    input
  end
end
