defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
#    alphabet = [{0, "a"}, {1, "b"}, {2, "c"}, {3, "d"}, {4, "e"}, {5, "f"}, {6, "g"}, {7, "h"}, {8, "i"}, {9, "j"}, {10, "k"}, {11, "l"}, {12, "m"}, {13, "n"}, {14, "o"}, {15, "p"}, {16, "q"}, {17, "r"}, {18, "s"}, {19, "t"}, {20, "u"}, {21, "v"}, {22, "w"}, {23, "x"}, {24, "y"}, {25, "z"}]

    text
    |> String.to_charlist
    |> List.foldl([], fn ch, acc -> [get_rot(shift, ch) | acc] end)
    |> to_string
    |> String.reverse
  end

  @ascii_lo_beg 97
  @ascii_lo_end 122
  @ascii_up_beg 65
  @ascii_up_end 90
  # a (ascii code 97) -> z (122)
  defp get_rot(shift, int_ch) do
    cond do
      # is uppercase?
      int_ch >= @ascii_up_beg and int_ch <= @ascii_up_end -> get_rotated_letter(int_ch, shift, @ascii_up_beg, @ascii_up_end)
      int_ch >= @ascii_lo_beg and int_ch <= @ascii_lo_end -> get_rotated_letter(int_ch, shift, @ascii_lo_beg, @ascii_lo_end)
      true -> int_ch
    end
  end

  defp get_rotated_letter(int_ch, shift, lower, upper) do
    cond do
      int_ch + shift > upper -> int_ch + shift - upper + lower - 1
      true -> int_ch + shift
    end
  end
end
