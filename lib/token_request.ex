defmodule RestTwitch.TokenRequest do
  use HTTPoison.Base

  # def get!(url, headers \\ [], options \\ []), 
  def get_auth!(access_token, url, headers \\ [], options \\ []) do 
    headers = req_headers("OAuth ", access_token, headers)

    get!(url, headers, options)
  end

  def req_headers(token_type, access_token, headers) do
    [{"Authorization", "#{token_type} #{access_token}"} | headers]
  end
end