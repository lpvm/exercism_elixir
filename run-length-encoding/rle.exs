defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    str_cp = string |> String.codepoints()
    encode_aux(str_cp, "", 0, "")
  end

  defp encode_aux([hd | tl], encoded, count, last) do
    cond do
      # first character to be processed
      encoded == "" and last == "" ->
        encode_aux(tl, encoded, 1, hd)

      # hd same as last character
      hd == last ->
        encode_aux(tl, encoded, count + 1, last)

      # last char different of hd
      true ->
        cond do
          # now: Y last: X
          count == 1 ->
            encode_aux(tl, encoded <> last, 1, hd)

          true ->
            encode_aux(tl, encoded <> to_string(count) <> last, 1, hd)
        end
    end
  end

  defp encode_aux([], encoded, count, last) do
    cond do
      # no initial string to encode
      encoded == "" and last == "" ->
        ""

      # initial string of same characters
      encoded == "" ->
        if count != 1, do: to_string(count) <> last, else: last

      true ->
        if count != 1 do
          encoded <> to_string(count) <> last
        else
          encoded <> last
        end
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    str_cp = String.codepoints(string)
    decode_aux(str_cp, "", "0")
  end

  def decode_aux([hd | tl], decoded, count) do
    case Integer.parse(hd) do
      :error ->
        # hd is letter and count == 0, single letter
        if count == "0" do
          decode_aux(tl, decoded <> hd, "0")
        else
          # hd is letter and count > 0, letter repeated `count` times
          decode_aux(tl, decoded <> String.duplicate(hd, String.to_integer(count)), "0")
        end

      _ ->
        if count == "0" do
          # hd is a string of a number
          # first number after letter or initial number
          decode_aux(tl, decoded, hd)
        else
          # number followed by number, ex: 12 (1: count, 2: hd)
          decode_aux(tl, decoded, count <> hd)
        end
    end
  end

  def decode_aux([], decoded, _) do
    decoded
  end
end

# RunLengthEncoder.encode("AABBBCCCC") == "2A3B4C"
