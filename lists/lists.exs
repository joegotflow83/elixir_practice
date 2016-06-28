ExUnit.start

defmodule ListTest do
  use ExUnit.Case

  def sample do
    ["Tim", "Joe", "Mike", "Jen"]
  end

  test "sigil" do
    assert sample == ~w(Tim Joe Mike Jen)
  end

  test "head" do
    [head | _] = sample
    assert head == "Tim"
  end

  test "tail" do
    [_ | tail] = sample
    assert tail == ~w(Joe Mike Jen)
  end

  test "last-item" do
    assert List.last(sample) == "Jen"
  end

  test "delete-item" do
    assert List.delete(sample, "Jen") == ~w(Tim Joe Mike)
    assert List.delete([1, 2, 3, 2], 2) == [1, 3, 2]
  end

  test "List.fold" do
    list = [20, 10, 5, 2.5]
    sum = List.foldr list, 0, &(&1 + &2)
    assert sum == 37.5
  end

  test "Enum.reduce" do
    list = [20, 10, 5, 2.5]
    sum = Enum.reduce list, 0, &(&1 + &2)
    assert sum == 37.5
  end

  test "wrap" do
    assert List.wrap(sample == sample)
    assert List.wrap(1) == [1]
    assert List.wrap([]) == []
    assert List.wrap(nil) == []
  end

  test "Enum.filter_map" do
    some = Enum.filter_map sample, &(String.first(&1) >= "M"), &(&1 <> " Morgan")
    assert some == ["Tim Morgan", "Mike Morgan"]
  end

  test "list-comprehension" do
    some = for n <- sample, String.first(n) < "M", do: n <> " Morgan"
    assert some == ["Joe Morgan", "Jen Morgan"]
  end

  test "manual reverse speed" do
    {microsec, reversed} = :timer.tc fn ->     # Erlang function, yay!
      Enum.reduce 1..1_000_000, [], fn (i, l) -> List.insert_at(l, 0, i) end
    end
    assert reversed == Enum.to_list(1_000_000..1)
    IO.puts "manual reverse took #{microsec} microsecs"
  end
end
