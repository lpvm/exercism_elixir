defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    words = phrase
    |> String.split
    |> List.foldl([], fn w, acc -> [(pigWord w) | acc] end)
    |> Enum.reverse

    [first_word | rest_words ] = words
    rest_words |> List.foldl(first_word, fn w, acc -> acc <> " " <> w end)
  end

  defp pigWord(word) do
    word_chars = to_charlist word
    vowel_pos = find_pos(word_chars, 0)
    IO.inspect(vowel_pos, label: "vowel_pos")

    cond do
      String.starts_with?(word, ["a", "e", "i", "o", "u", "y"]) -> word <> "ay"
      true -> String.slice(word, vowel_pos, String.length(word) - vowel_pos) <> String.slice(word, 0, vowel_pos) <> "ay"
    end
  end

  defp find_pos([hd | tl], pos) when hd not in 'abcdey', do: find_pos(tl, pos + 1)
  defp find_pos([hd | tl], pos), do: pos
  defp find_pos([], pos), do: pos
end
#assert PigLatin.translate("apple") == "appleay" #assert PigLatin.translate("pig") == "igpay" 
