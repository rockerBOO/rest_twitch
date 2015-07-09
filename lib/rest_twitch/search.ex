defmodule RestTwitch.Search do
  import ExPrintf
  alias RestTwitch.Request
  use RestTwitch.RestBase

  @doc """
  GET /users/:user  Get user object

  ## Example
  streams()
  """
  def streams(opts \\ %{}, cache \\ nil) do
    "/search/streams?%s"
      |> sprintf([URI.encode_query(opts)])
      |> Request.get_cache_decode!(cache)
      |> get_list("streams")
  end
end