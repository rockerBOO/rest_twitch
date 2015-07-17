defmodule RestTwitch.Error do
  defexception [:reason, :code]
  def message(%__MODULE__{reason: reason}), do: inspect reason
end