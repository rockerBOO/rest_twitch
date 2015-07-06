defmodule RestTwitch.Search do
  import ExPrintf
  alias RestTwitch.Request

  @doc """
  GET /users/:user  Get user object

  ## Example
  streams()
  """
  def streams(opts \\ %{}, cache \\ nil) do
    "/search/streams?%s"
      |> sprintf([URI.encode_query(opts)])
      |> Request.get_cache_decode!(cache)
      |> Map.fetch!("streams")
  end
end