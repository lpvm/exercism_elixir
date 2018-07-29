defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    list
    #|> List.foldl([], fn el, acc -> if fun.(el), do: [el | acc], else: acc end)
    |> List.foldl([], fn el, acc -> if apply(fun, [el]), do: [el | acc], else: acc end)
    |> Enum.reverse
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    list
    |> List.foldl([], fn el, acc -> if not fun.(el), do: [el | acc], else: acc end)
    |> Enum.reverse
  end
end
