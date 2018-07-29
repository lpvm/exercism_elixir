if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("pig_latin.exs", __DIR__)
end

ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)

defmodule PigLatinTest do
  use ExUnit.Case


  describe "first consonant letters and ay are moved to the end of words that start with consonants" do
#    @tag :pending
    test "word beginning with x" do
      assert PigLatin.translate("xenon") == "enonxay"
    end
  end

end
