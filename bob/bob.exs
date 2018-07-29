defmodule Bob do

  def hey(input) do

    special_chars = [",", "'", "%", "^", "*", "@", "#", "$", "(", ")", "[", "]"]
    ending_chars = [".", "!", "?"]
    blanks = [" "]
    last_char = String.last(input)
    input_but_last = String.slice(input, -String.length(input)..-2)
    
    stripped_input = if last_char in special_chars do
      input_but_last
      |> remove_superfluous_chars(special_chars)
      |> remove_superfluous_chars(ending_chars)
      |> remove_superfluous_chars(blanks)
    else
      input
      |> remove_superfluous_chars(special_chars)
      |> remove_superfluous_chars(ending_chars)
      |> remove_superfluous_chars(blanks)
    end

    IO.puts("input: " <> input <> " <> " <> " stripped: " <> stripped_input <> "::" <> " length:" <> to_string(String.length(stripped_input)))

    cond do
      stripped_input == "" -> "Fine. Be that way!"      
      last_char not in ending_chars && all_numbers(stripped_input) -> "Whatever."
      last_char not in ending_chars && all_caps(stripped_input) -> "Whoa, chill out!"

      last_char == "!" && all_caps(stripped_input) -> "Whoa, chill out!"
      last_char == "!" -> "Whatever."
      last_char == "." -> "Whatever."
      last_char == "?" && all_numbers(stripped_input) -> "Sure."
      last_char == "?" && all_caps(stripped_input) -> "Calm down, I know what I'm doing!"
      last_char == "?" -> "Sure."
      true -> raise "Your implementation goes here"
    end
  end

  defp remove_superfluous_chars(str,superfluous_chars) do
    str
    |> String.codepoints
    |> List.foldl("", fn(ch, acc) -> if ch not in superfluous_chars, 
      do: acc <> ch, else: acc end)
  end

  defp all_caps(str), do: str === String.upcase(str) and String.length(str) != 0
  
  defp all_numbers(str) do
    # re = Regex.compile!("^[+-]?[0-9]*\.?[0-9]*$")
    # Regex.match?(re, "01") # true
    re = Regex.compile!("^[0-9]+$")
    Regex.match?(re, str)
  end
end
