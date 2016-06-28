defmodule CowInterrogator do
    def get_name do
        IO.gets("What is your name? ")
        |> String.strip
    end

    def get_cow_lower do
        IO.getn("Do you like cows? [y|n] ", 1)
    end

    def interrogate do
        name = get_name
        case String.downcase(get_cow_lower) do
            "y" ->
                IO.puts "Great! Here's a cow for you #{name}:"
                IO.puts cow_art
            "n" ->
                IO.puts "Thats's a shame, #{name}."
             _  ->
                IO.puts "You should have entered 'y' or 'n'."
        end
    end

    def cow_art do
        path = Path.expand("support/cow.txt", __DIR__)
        case File.read(path) do
            {:ok, art} -> art
            {:error, _} -> IO.puts "Error cow.txt not found"; System.hault(1)
        end
    end
end

CowInterrogator.interrogate
