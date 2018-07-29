defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    #counthelper(0, strand, nucleotide)
    c = for l <- strand, l == nucleotide, into: [], do: l
    length c
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    # m = %{?A => 0, ?C => 0, ?G => 0, ?T => 0}
    Enum.reduce(strand, %{?A => 0, ?T => 0, ?C => 0, ?G => 0}, fn (char, acc)  ->
      acc = %{acc | char => acc[char] + 1}
      end)

  end

end

IO.inspect(NucleotideCount.count('AATAA', ?A))
IO.inspect(NucleotideCount.histogram('AATAA'))
