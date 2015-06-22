defmodule RestTwitch.Request.OLD do
  use HTTPoison.Base

  def process_url("/" <> url) do
    "https://api.twitch.tv/kraken" <> url
  end

  def process_url(url) do
    "https://api.twitch.tv/kraken/" <> url
  end

  @doc """
  Process a response body for the json key, with the struct_map mapping

  ## Example
      iex> "{\\"streams\\": [{\\"_id\\": 2983782}, {\\"_id\\": 298343}]}" |>
      ...> RestTwitch.Request.process_body("streams", %{"streams" => [RestTwitch.Streams.Stream]})
      [%RestTwitch.Streams.Stream{_id: 2983782, average_fps: nil,
        channel: RestTwitch.Channels.Channel, created_at: nil, game: nil,
        video_height: nil, viewers: nil},
       %RestTwitch.Streams.Stream{_id: 298343, average_fps: nil,
        channel: RestTwitch.Channels.Channel, created_at: nil, game: nil,
        video_height: nil, viewers: nil}]

  """
  def decode_json(body, key, as) when is_map(as) do
    Poison.decode!(body, as: as)
      |> Map.fetch!(key)
  end

  @doc """
  Process a response body for the json key, with the struct_map mapping

  ## Example
      iex> "{\\"stream\\": {\\"_id\\": 2983782}" |>
      ...> RestTwitch.Request.process_body(%{"stream" => RestTwitch.Streams.Stream})
      [%RestTwitch.Streams.Stream{_id: 2983782, average_fps: nil,
        channel: RestTwitch.Channels.Channel, created_at: nil, game: nil,
        video_height: nil, viewers: nil}]
  """
  def process_body(body, struct_map) when is_map(struct_map) do
    Poison.decode!(body, 
      as: struct_map)
  end

  def process_body(body, struct) when is_atom(struct) do
    Poison.decode!(body, 
      as: struct)
  end

  @doc """
  Process a response body for the json key

  ## Example
      iex> "{\\"stream\\": {\\"_id\\": 2983782}}" |>
      ...> RestTwitch.Request.process_body("stream")
      %{"_id" => 2983782}
  """
  def process_body(body, key) do 
    Poison.decode!(body)
      |> Map.fetch!(key)
  end

  def encode(opts) do
    "?" <> URI.encode_query(opts)
  end

  def get_body(url, token, opts) do 
    get_body(url <> encode(opts), token)
  end

  def get_auth(url, auth) do
    # get()
    {:ok, auth}
  end

  def get_body(url, token) do
    IO.inspect url
 
    # auth
    # auth = System.get_env("TWITCH_ACCESS_TOKEN")

    # headers = [{"Authorization", "OAuth " <> token.access_token}]

    token |> Elirc.TokenRequest.get!(url)  
    # get!(url, headers).body
  end

  def get_body(url) do
    IO.inspect url 

    get!(url).body
  end

  def post(url, body) do 
    post!(url, body)
  end

  def put(url, data) do 
    # {
    #   "channel": {
    #     "status": "Playing cool new game!",
    #     "game": "Diablo",
    #     "delay": 60
    #     }
    # }
    # channel[status]=Playing+cool+new+game!&channel[game]=Diablo&channel[delay]=0

    post!(url, data)
  end
end