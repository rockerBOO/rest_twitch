defmodule RestTwitch.Request do
  use HTTPoison.Base

  @url "https://api.twitch.tv/kraken"
  def process_url(url) do
    case String.downcase(url) do
      <<"http://"::utf8, _::binary>> -> url
      <<"https://"::utf8, _::binary>> -> url
      _ -> @url <> url
    end
  end

  def encode_query_url(url, opts) do
    url <> "?" <> URI.encode_query(opts)
  end

  # Decode json from body, parse out key as struct_map
  # decode_json("{...json...}", "users", [RestTwitch.Users.User])
  def decode_json(body, key, struct) 
    when is_atom(struct) do
    map = Map.new
    struct_map = Map.put(map, key, struct)
    Poison.decode!(body, as: struct_map)
      |> Map.fetch!(String.to_atom(key))
  end

  # decode_json("{...json...}", %{"channels" => [RestTwitch.Channels.Channel]})
  def decode_json(body, struct_map) when is_map(struct_map) do
    Poison.decode!(body, as: struct_map)
  end

  @doc """
  
  ## Examples
  
  decode_json("{...json...}", RestTwitch.Channels.Channel)
  decode_json("{...json...}", [RestTwitch.Channels.Channel])
  """
  def decode_json(body, struct) when is_atom(struct) do
    Poison.decode!(body, as: struct)
  end
end