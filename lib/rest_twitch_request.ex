defmodule RestTwitch.Request do
  use HTTPoison.Base

  def process_url(url) do
    "https://api.twitch.tv/kraken/" <> url
  end

  def process_response_body(body, k, struct) do
    struct_map = Map.new
      |> Map.put(k, [struct])

    
    Poison.decode!(body, 
      as: struct_map)
      |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

  def process_response_body(body, atom) do
    Poison.decode!(body[atom])
      |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

  def request_get(url) do
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