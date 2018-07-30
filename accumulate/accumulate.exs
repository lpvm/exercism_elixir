defmodule Accumulate do
  @doc """
    Given a list and a function, apply the function to each list item and
    replace it with the function's return value.

    Returns a list.

    ## Examples

      iex> Accumulate.accumulate([], fn(x) -> x * 2 end)
      []

      iex> Accumulate.accumulate([1, 2, 3], fn(x) -> x * 2 end)
      [2, 4, 6]

  """

  @spec accumulate(list, (any -> any)) :: list
  def accumulate(list, fun) do
    accumulate_aux(list, fun, []) 
  end

  defp accumulate_aux([hd | tl], fun, acc) do
    acc = acc ++ [fun.(hd)]
    accumulate_aux(tl, fun, acc)
  end

  defp accumulate_aux([], _, acc) do
    acc 
  end
end
