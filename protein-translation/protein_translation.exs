defmodule ProteinTranslation do


#  strand = "AUG UUU UAA"
  @codon_protein %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"}

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    list_codons = rna |> to_charlist |> Enum.chunk_every(3)
    proteins = get_proteins([], list_codons)
    if List.first(proteins), do: {:ok, Enum.reverse proteins}, else: {:error, "invalid RNA"}
  end

#  strand = "UGG UGU UAU UAA UGG UUU"
  defp get_proteins(proteins, [hd | tl]) do
    proteins = case of_codon(to_string(hd)) do
      {:ok, protein} when protein != "STOP"-> get_proteins([protein | proteins], tl)
      {:ok, protein} when protein == "STOP"-> proteins
      {:error, _} -> []
    end
  end

  defp get_proteins(proteins, []) do
    proteins
  end


@doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do

    if Map.has_key?(@codon_protein, codon), do: {:ok, @codon_protein[codon]}, else: {:error, "invalid codon"}
  end
end

#IO.Puts ProteinTranslation.of_codon("UGU")
#IO.Puts ProteinTranslation.of_codon("UUA")
