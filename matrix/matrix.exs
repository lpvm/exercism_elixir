defmodule Matrix do
  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    input
    |> String.split("\n")
    |> List.foldl([], fn n, acc -> acc ++ [String.split(n, " ")] end)
    |> Enum.map(&Enum.map(&1, fn c -> String.to_integer(c) end))

    # the last functions could be written as
    # for f <- input do
    # Enum.map(f, fn x -> String.to_integer(x) end)
    # end
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix) do
    matrix
    |> List.foldl(
      "",
      fn li, acc ->
        acc <>
          String.trim(List.foldl(li, "", fn x, acc2 -> acc2 <> Kernel.to_string(x) <> " " end)) <> "\n"
      end
    )
    |> String.trim()
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(matrix) do
    matrix
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index) do
    Enum.at(matrix, index)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix) do
    matrix
    |> List.zip
    |> Enum.map(&Tuple.to_list(&1))
    # |> Enum.map(fn l -> Tuple.to_list(l) end)
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    List.foldl(matrix, [], fn l, acc -> acc ++ [Enum.at(l, index)] end)
  end
end
