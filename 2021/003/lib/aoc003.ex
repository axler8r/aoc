defmodule Aoc003 do
  def problem1 do
    {γ, ε} = File.read!("data/input")
    |> calculate_rates()

    String.to_integer(γ, 2) * String.to_integer(ε, 2)
  end

  defp calculate_rates(data) do
    do_calculate_rates(data, {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
  end

  defp do_calculate_rates(<<>>, {m, n, o, p, q, r, s, t, u, v, w, x} = _acc) do
    γm = case m < 0, do: (true -> ?0; _ -> ?1)
    γn = case n < 0, do: (true -> ?0; _ -> ?1)
    γo = case o < 0, do: (true -> ?0; _ -> ?1)
    γp = case p < 0, do: (true -> ?0; _ -> ?1)
    γq = case q < 0, do: (true -> ?0; _ -> ?1)
    γr = case r < 0, do: (true -> ?0; _ -> ?1)
    γs = case s < 0, do: (true -> ?0; _ -> ?1)
    γt = case t < 0, do: (true -> ?0; _ -> ?1)
    γu = case u < 0, do: (true -> ?0; _ -> ?1)
    γv = case v < 0, do: (true -> ?0; _ -> ?1)
    γw = case w < 0, do: (true -> ?0; _ -> ?1)
    γx = case x < 0, do: (true -> ?0; _ -> ?1)

    εm = case m < 0, do: (true -> ?1; _ -> ?0)
    εn = case n < 0, do: (true -> ?1; _ -> ?0)
    εo = case o < 0, do: (true -> ?1; _ -> ?0)
    εp = case p < 0, do: (true -> ?1; _ -> ?0)
    εq = case q < 0, do: (true -> ?1; _ -> ?0)
    εr = case r < 0, do: (true -> ?1; _ -> ?0)
    εs = case s < 0, do: (true -> ?1; _ -> ?0)
    εt = case t < 0, do: (true -> ?1; _ -> ?0)
    εu = case u < 0, do: (true -> ?1; _ -> ?0)
    εv = case v < 0, do: (true -> ?1; _ -> ?0)
    εw = case w < 0, do: (true -> ?1; _ -> ?0)
    εx = case x < 0, do: (true -> ?1; _ -> ?0)

    {<<γm, γn, γo, γp, γq, γr, γs, γt, γu, γv, γw, γx>>,
     <<εm, εn, εo, εp, εq, εr, εs, εt, εu, εv, εw, εx>>}
  end

  defp do_calculate_rates(
      <<a, b, c, d, e, f, g, h, i, j, k, l, 10, tail::binary>> = _data,
      {m, n, o, p, q, r, s, t, u, v, w, x} = _acc) do
    δm = case a, do: ( ?1 -> m + 1; _ -> m - 1 )
    δn = case b, do: ( ?1 -> n + 1; _ -> n - 1 )
    δo = case c, do: ( ?1 -> o + 1; _ -> o - 1 )
    δp = case d, do: ( ?1 -> p + 1; _ -> p - 1 )
    δq = case e, do: ( ?1 -> q + 1; _ -> q - 1 )
    δr = case f, do: ( ?1 -> r + 1; _ -> r - 1 )
    δs = case g, do: ( ?1 -> s + 1; _ -> s - 1 )
    δt = case h, do: ( ?1 -> t + 1; _ -> t - 1 )
    δu = case i, do: ( ?1 -> u + 1; _ -> u - 1 )
    δv = case j, do: ( ?1 -> v + 1; _ -> v - 1 )
    δw = case k, do: ( ?1 -> w + 1; _ -> w - 1 )
    δx = case l, do: ( ?1 -> x + 1; _ -> x - 1 )

    do_calculate_rates(tail, {δm, δn, δo, δp, δq, δr, δs, δt, δu, δv, δw, δx})
  end
end
