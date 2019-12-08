defmodule Dictionary.WordList do

  @me __MODULE__ # whenever @me is used, the module's name is passed through
  # __MODULE__ is equivalent to :Dictionary.WordList

  def start_link() do
    Agent.start_link(&word_list/0, name: @me)
  end

  def random_word() do
    # if :rand.uniform < 0.33 do
    # Agent.get(@me, fn _ -> exit(:boom) end) # one time in three, Agent will run a function that exists with an error (to restart process)
    # end
    Agent.get(@me, &Enum.random/1)
  end

  def word_list() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__) # source file directory of the module (not top level of application)
    |> File.read!()
    |> String.split(~r/\n/)
  end
end
