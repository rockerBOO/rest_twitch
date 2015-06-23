defmodule RestTwitch.TokenRequest do
  use HTTPoison.Base
  alias RestTwitch.Request

  @url "https://api.twitch.tv/kraken"
  def process_url(url) do
    case String.downcase(url) do
      <<"http://"::utf8, _::binary>> -> url
      <<"https://"::utf8, _::binary>> -> url
      _ -> @url <> url
    end
  end

  # def get!(url, headers \\ [], options \\ []),
  def get_token_body!(url, token, headers \\ [], options \\ []) do
    headers = req_headers("OAuth ", token, headers)

    case Request.get_body(url, headers, options) do
      {:ok, body} -> body
      {:error, error} -> Request.handle_error(error)
    end
  end

  def put_token!(url, token, body, headers \\ [], opts \\ []) do
    headers = req_headers("OAuth ", token, headers)

    case Request.do_put(url, body, headers, opts) do
      {:ok, response} -> response
      {:error, error} -> Request.handle_error(error)
    end
  end

  # token == TWITCH_ACCESS_TOKEN
  def req_headers(token_type, token, headers) do
    [{"Authorization", "#{token_type} #{token}"} | headers]
  end
end