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
    vowel_pos = find_pos(String.codepoints(word), 0)
    first_letter = String.first word
    second_letter = String.at(word, 1)
    third_letter = String.at(word, 2)

    cond do
      first_letter in ["a", "e", "i", "o", "u"] -> word <> "ay"
      first_letter in ["x", "y"] and second_letter not in ["a", "e", "i", "o", "u"] -> word <> "ay"
      first_letter in ["q"] and second_letter == "u" -> String.slice(word, 2, String.length(word) - 2) <> String.slice(word, 0, 2)<> "ay"
      first_letter in ["s"] and second_letter not in ["a", "e", "i", "o", "u"] and third_letter == "u" -> String.slice(word, 3, String.length(word) - 3) <> String.slice(word, 0, 3) <> "ay"
      true -> String.slice(word, vowel_pos, String.length(word) - vowel_pos) <> String.slice(word, 0, vowel_pos) <> "ay"
    end
  end

  defp find_pos([hd | tl], pos) when hd not in ["a","e","i","o","u"], do: find_pos(tl, pos + 1)
  defp find_pos([hd | tl], pos), do: pos
  defp find_pos([], pos), do: pos
end
#assert PigLatin.translate("apple") == "appleay" #assert PigLatin.translate("pig") == "igpay" 
