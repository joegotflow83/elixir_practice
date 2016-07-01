ExUnit.start

defmodule MapTest do
  use ExUnit.Case

  def sample do
    %{foo: 'bar', baz: 'quz'}
  end

  test "Maps.get" do
    assert Map.get(sample, :foo) == 'bar'
    assert Map.get(sample, :non_existant) == nil
  end

  test "[]" do
    assert sample[:foo] == 'bar'
    assert sample[:non_existant] == nil
  end

  test "." do
    assert sample.foo == 'bar'
    assert_raise KeyError, fn ->
      sample.non_existant
    end
  end

  test "Map.fetch" do
    {:ok, val} = Map.fetch(sample, :foo)
    assert val == 'bar'
    :error = Map.fetch(sample, :non_existant)
  end

  test "Map.put" do
    assert Map.put(sample, :foo, 'bob') == %{foo: 'bob', baz: 'quz'}
    assert Map.put(sample, :far, 'bar') == %{foo: 'bar', baz: 'quz', far: 'bar'}
  end
end
