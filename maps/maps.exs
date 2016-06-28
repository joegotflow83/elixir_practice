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
end
