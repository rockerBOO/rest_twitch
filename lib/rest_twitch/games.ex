defmodule RestTwitch.Games do
  import ExPrintf
  alias RestTwitch.Request
    # {
    #   "game": {
    #     "name": "Counter-Strike: Global Offensive",
    #     "box": {
    #       "large": "http://static-cdn.jtvnw.net/ttv-boxart/Counter-Strike:%20Global%20Offensive-272x380.jpg",
    #       "medium": "http://static-cdn.jtvnw.net/ttv-boxart/Counter-Strike:%20Global%20Offensive-136x190.jpg",
    #       "small": "http://static-cdn.jtvnw.net/ttv-boxart/Counter-Strike:%20Global%20Offensive-52x72.jpg",
    #       "template": "http://static-cdn.jtvnw.net/ttv-boxart/Counter-Strike:%20Global%20Offensive-{width}x{height}.jpg"
    #     },
    #     "logo": {
    #       "large": "http://static-cdn.jtvnw.net/ttv-logoart/Counter-Strike:%20Global%20Offensive-240x144.jpg",
    #       "medium": "http://static-cdn.jtvnw.net/ttv-logoart/Counter-Strike:%20Global%20Offensive-120x72.jpg",
    #       "small": "http://static-cdn.jtvnw.net/ttv-logoart/Counter-Strike:%20Global%20Offensive-60x36.jpg",
    #       "template": "http://static-cdn.jtvnw.net/ttv-logoart/Counter-Strike:%20Global%20Offensive-{width}x{height}.jpg"
    #     },
    #     "_links": {},
    #     "_id": 32399,
    #     "giantbomb_id": 36113
    #   },
    #   "viewers": 23873,
    #   "channels": 305
    # },
  defmodule Game do
    defstruct [:name,
              :box,
              :logo,
              :_links,
              :_id,
              :giantbomb_id,
              :viewers,
              :channels]
  end

  @doc """
  GET /games/top  Get games by number of viewers

  limit   optional  integer   Maximum number of objects in array. Default is 10. Maximum is 100.
  offset  optional  integer   Object offset for pagination. Default is 0.

  ## Examples

  RestTwitch.Games.top()
  """
  def top(opts \\ %{}, cache \\ nil) do
    "/games/top?%s"
      |> sprintf([URI.encode_query(opts)])
      |> Request.get_cache_decode!(cache)
      |> Map.fetch!("top")
  end
end