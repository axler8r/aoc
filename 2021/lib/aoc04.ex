defmodule AdventOfCode.Day04 do
  @spec problem1 :: any
  def problem1 do
    {numbers, boards} = input()

    numbers
    |> Enum.reduce_while([], fn elem, acc ->
      matches = [elem | acc]

      case Enum.find(boards, &winning_board?(&1, matches)) do
        nil -> {:cont, matches}
        board -> {:halt, Enum.sum(unmatched_numbers(board, matches)) * elem}
      end
    end)
  end

  @spec problem2 :: any
  def problem2 do
    {numbers, boards} = input()

    numbers
    |> Enum.reduce_while({boards, []}, fn elem, {boards, acc} ->
      matches = [elem | acc]

      case boards do
        [board] ->
          if winning_board?(board, matches) do
            {:halt, Enum.sum(unmatched_numbers(board, matches)) * elem}
          else
            {:cont, {boards, matches}}
          end

        _ ->
          {:cont, {Enum.reject(boards, &winning_board?(&1, matches)), matches}}
      end
    end)
  end

  defp input do
    [numbers | boards] =
      File.read!("data/04/input")
      |> String.split("\n\n", trim: true)

    numbers =
      numbers
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    boards =
      boards
      |> Enum.map(fn board ->
        board
        |> String.split(~r/\s+/, trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    {numbers, boards}
  end

  defp match_row_or_column?(list, numbers) do
    Enum.all?(list, &(&1 in numbers))
  end

  defp unmatched_numbers(board, numbers) do
    Enum.reject(board, &(&1 in numbers))
  end

  defp winning_board?(
         [
           a1, a2, a3, a4, a5,
           b1, b2, b3, b4, b5,
           c1, c2, c3, c4, c5,
           d1, d2, d3, d4, d5,
           e1, e2, e3, e4, e5
         ],
         numbers
       ) do
    match_row_or_column?([a1, a2, a3, a4, a5], numbers) or
      match_row_or_column?([b1, b3, b3, b4, b5], numbers) or
      match_row_or_column?([c1, c2, c3, c4, c5], numbers) or
      match_row_or_column?([d1, d2, d3, d4, d5], numbers) or
      match_row_or_column?([e1, e2, e3, e4, e5], numbers) or
      match_row_or_column?([a1, b1, c1, d1, e1], numbers) or
      match_row_or_column?([a2, b2, c2, d2, e2], numbers) or
      match_row_or_column?([a3, b3, c3, d3, e3], numbers) or
      match_row_or_column?([a4, b4, c4, d4, e4], numbers) or
      match_row_or_column?([a5, b5, c5, d5, e5], numbers)
  end
end
