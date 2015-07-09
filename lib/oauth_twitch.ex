defmodule OAuth2.Twitch do
  use OAuth2.Strategy

  @state_token "RestTwitch-Temporary-Unique-Token"

  # Public API

  def new do
    OAuth2.new([
      strategy: __MODULE__,
      client_id: System.get_env("TWITCH_CLIENT_ID"),
      client_secret: System.get_env("TWITCH_CLIENT_SECRET"),
      redirect_uri: System.get_env("TWITCH_REDIRECT_URI"),
      site: "https://api.twitch.tv/kraken/",
      authorize_url: "https://api.twitch.tv/kraken/oauth2/authorize",
      token_url: "https://api.twitch.tv/kraken/oauth2/token"
    ])
  end

  # authorize_url!(%{scope: "user_read"})
  def authorize_url!(params) do
    oauth = new()
    |> put_param(:state, @state_token)
    |> put_param(:scope, params.scope)
    |> OAuth2.Client.authorize_url!(params)
  end

  def get_token!(params \\ [], headers \\ []) do
    new()
      |> put_param(:state, @state_token)
      |> OAuth2.Client.get_token!(params, headers)
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end
end