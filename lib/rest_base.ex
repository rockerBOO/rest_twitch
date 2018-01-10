defmodule RestTwitch.RestBase do
  defmacro __using__(_) do
    quote do
      def get_list(dataset, key) do
        case Map.fetch(dataset, key) do
          {:ok, list} -> list
          :error -> []
        end
      end
    end
  end
end