defmodule RestTwitch.Request do
  use HTTPoison.Base
  alias RestTwitch.Cache.Options
  alias RestTwitch.Cache
  alias RestTwitch.Error

  @url "https://api.twitch.tv/kraken"
  def process_url(url) do
    case String.downcase(url) do
      <<"http://"::utf8, _::binary>> -> url
      <<"https://"::utf8, _::binary>> -> url
      _ -> @url <> url
    end
  end

  # [{"length", 30}] -> "length=30"
  def list_to_string(list) do
    Plug.Conn.Query.encode(list)
  end

  def encode_query(opts) do
    URI.encode_query(opts)
  end

  # Decode json from body, parse out key as struct_map
  # decode_json("{...json...}", "users", [RestTwitch.Users.User])
  def decode_json!(body, key, struct) do
    map = Map.new
    struct_map = Map.put(map, key, struct)
    Poison.decode!(body, as: struct_map)
      |> Map.fetch!(key)
  end

  # decode_json("{...json...}", %{"channels" => [RestTwitch.Channels.Channel]})
  def decode_json!(body, struct_map) when is_map(struct_map) do
    Poison.decode!(body, as: struct_map)
  end

  @doc """

  ## Examples

  decode_json("{...json...}", RestTwitch.Channels.Channel)
  decode_json("{...json...}", [RestTwitch.Channels.Channel])
  """
  def decode_json!(body, struct) when is_atom(struct) do
    Poison.decode!(body, as: struct)
  end

  def get_token_body(url, token, headers \\ [], opts \\ []) do
    get_token_body(url, req_headers(headers, token), opts)
  end

  def get_token_body!(url, token, headers \\ [], opts \\ []) do
    case get_body(url, req_headers(headers, token), opts) do
      {:ok, body} -> body
      {:error, error} -> raise error
    end
  end

  def get_body!(url, headers \\ [], opts \\ []) do
    case get_body(url, headers, opts) do
      {:ok, body} -> body
      {:error, error} -> raise error
    end
  end

  def get_body(url, headers \\ [], opts \\ []) do
    case get(url, headers) do
      {:ok, r} -> handle_response(r, "GET_BODY #{url}")
      {:error, error} -> %Error{reason: error}
    end
  end

  def hash_cache_key(to_hash) do
    :crypto.hash(:md5, to_hash) |> Base.encode16
  end

  def get_cache_decode!(url, config \\ nil, headers \\ [], opts \\ []) do
    key = hash_cache_key(url)

    IO.inspect url
    IO.inspect key
    IO.puts "cache"
    IO.inspect :twitch_cache

    if :twitch_cache do
      case Cache.get(key) do
        :undefined -> IO.inspect "NOT FROM CACHE"; get_decode_and_cache(url, config, headers, opts)
        value -> IO.puts "FROM CACHE"; value |> Poison.decode!()
      end
    else
      get_body!(url, headers, opts)
        |> Poison.decode!()
    end
  end

  def get_decode_and_cache(url, config, headers, opts) do
    value = get_body!(url, headers, opts)

    if :twitch_cache do
      key = hash_cache_key(url)

      set_to_cache_and_decode(key, value, config)
    else
      value
    end
  end

  def set_to_cache_and_decode(key, value, config) do
    IO.inspect "SET CACHE KEY"
    IO.inspect key
    # IO.inspect value
    IO.inspect config

    Cache.set(key, value)

    case config do
      %{ttl: ttl} -> Cache.expire(key, ttl); value |> Poison.decode!()
      _ -> value |> Poison.decode!()
    end
  end

  def get_and_decode(url, headers \\ [], opts \\ []) do
    get_body!(url, headers, opts)
      |> Poison.decode!()
  end

  # "/commerical", [{"Length", 30}]
  def do_put!(url, body, headers \\ [], opts \\ []) do
    case do_put(url, body, headers, opts) do
      {:ok, response} -> response
      {:error, error} -> handle_error(error)
    end
  end

  def do_put(url, data, headers \\ [], opts \\ []) do
    body = list_to_string(data)
    case put(url, body, headers, opts) do
      {:ok, r} -> handle_response(r, "PUT #{url} #{body} #{IO.inspect opts}")
      {:error, error} -> %Error{reason: error}
    end
  end

  def do_delete(url, headers \\ [], opts \\ []) do
    case delete(url, headers, opts) do
      {:ok, r} -> handle_response(r, "DELETE #{url} {IO.inspect opts}")
      {:error, error} -> %Error{reason: "Unprocessable Entity"}
    end
  end

  def handle_error(error) do
    raise error
  end

  def handle_response(r, action \\ "") do
    case r.status_code do
      200 -> {:ok, r.body}
      204 -> {:ok, :ok}
      401 -> {:error, %Error{reason: "Access Denied #{action} #{get_error_message(r.body)}"}}
      404 -> {:error, %Error{reason: "Not found #{action}"}}
      422 -> {:error, %Error{reason: "Unprocessable Entity"}}
      _ -> {:error, %Error{reason: "Unprocessable Status Code #{r.status_code}"}}
    end
  end

  def get_error_message(html) do
    html
      |> Poison.decode!()
      |> Map.fetch!("message")
  end

  def process_request_headers(headers) do
    client_headers = [{"Client-ID", System.get_env("TWITCH_CLIENT_ID")} | headers]
    [{"Accept", "application/vnd.twitchtv.v3+json"} | client_headers]
  end

  # token == TWITCH_ACCESS_TOKEN
  def req_headers(headers, token) do
    [{"Authorization", "OAuth #{token}"} | headers]
  end
end