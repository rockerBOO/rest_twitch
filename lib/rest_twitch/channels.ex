defmodule RestTwitch.Channels do
  alias RestTwitch.Request
  import ExPrintf

  defmodule Channel do
    defstruct [
      :mature,
      :status,
      :broadcaster_language,
      :display_name,
      :game,
      :delay,
      :language,
      :_id,
      :name,
      :created_at,
      :updated_at,
      :logo,
      :banner,
      :video_banner,
      :background,
      :profile_banner,
      :profile_banner_background_color,
      :partner,
      :url,
      :views,
      :followers,
      :_link,
    ]
  end

  @doc """
  GET /channels/:channel   Get channel object
  Get a channel object

  ## Examples

  RestTwitch.Channels.get("test_channel")
  """
  def get(channel) do
    "/channels/%s"
      |> sprintf([channel])
      |> Request.get_cached_decode!()
  end

  @doc """
  GET /channels/:channel/videos   Get channel's list of videos
  Get the list of videos on the channel

  limit       int  Maximum number of objects in array. Default is 10. Maximum is 100.

  offset      int  Object offset for pagination. Default is 0.

  broadcasts  bool Returns only broadcasts when true. Otherwise only highlights are returned. Default is false.

  hls         bool Returns only HLS VoDs when true. Otherwise only non-HLS VoDs are returned. Default is false.

  ## Examples
  RestTwitch.Channels.videos("test_channel", %{"broadcasts" => false, "hls" => false})
  """
  def videos(channel, opts \\ %{}) when is_map(opts) do
    "/channels/%s/videos?%s"
      |> sprintf([channel, URI.encode_query(opts)])
      |> Request.get_body!()
      |> Request.decode_json("videos", [RestTwitch.Videos.Video])
  end

  @doc """
  GET /channels/:channel/follows  Get channel's list of following users
  Get the list of following users on the channel

  limit      optional  integer  Maximum number of objects in array. Default is 25. Maximum is 100.

  offset     optional  integer  Object offset for pagination. Default is 0.

  direction  optional  string   Creation date sorting direction. Default is desc. Valid values are asc and desc.

  ## Examples
  RestTwitch.Channels.followers("test_user1", [direction: "desc"]})
  """
  def followers(channel, opts \\ []) do
    "/channels/%s/follows?%s"
      |> sprintf([channel, URI.encode_query(opts)])
      |> Request.get_body!()
      |> Request.decode_json!("follows", [RestTwitch.Follows.Follow])
  end

  @doc """
  # Authenticated, required scope: channel_read
  GET /channels/:channel/editors  Get channel's list of editors
  Get the list of editors on the channel

  ## Examples
  token = OAuth2.AccessToken.new(%{
  "token_type" => "OAuth ",
  "access_token" => System.get_env("TWITCH_ACCESS_TOKEN")
  }, OAuth2.Twitch.new())

  RestTwitch.Channels.editors(token, "test_channel")
  """
  def editors(token, channel) do
    "/channels/%s/editors"
      |> sprintf([channel])
      |> Request.get_body!(token)
      |> Poison.decode!()
      # |> Request.process_body("users", %{"users" => [RestTwitch.Users.User]})
  end

  @doc """
  Get list of teams channel belongs to

  ## Examples
  RestTwitch.Channels.teams("test_user1")
  """
  def teams(token, channel) do
    "/channels/%s/teams"
      |> sprintf([channel])
      |> Request.get_body!(token)
      |> Request.decode_json!("teams", [RestTwitch.Teams.Team])
  end

  @doc """
  Authenticated, required scope: channel_editor

  PUT /channels/:channel  Update channel object
  Update channel object

  # DATA

  status  string  Channel's title.

  game    string  Game category to be classified as.

  delay   string  Channel delay in seconds. Requires the channel owner's OAuth token.

  ## Examples

  token = System.get_env("TWITCH_ACCESS_TOKEN")

  RestTwitch.Channels.put("rockerboo", [status: "ElircBOT Takeover. Hand over the CPU CYCLES!!!", game: "Programming"])

  """
  def put(channel, data) do
    sprintf("/channels/%s", [channel])
      |> Request.do_put!(data)
  end

  @doc """
  # Authenticated, required scope: channel_commercial
  POST /channels/:channel/commercial  Start a commercial on channel
  Start a commercial on channel
  length = length of commerical

  ## Examples

  token = System.get_env("TWITCH_ACCESS_TOKEN")

  RestTwitch.Channels.commerical(token, channel, 30)

  """
  def commerical(token, channel, length \\ 30) do
    "/channels/%s/commercial"
      |> sprintf([channel])
      |> Request.do_post!([{"length", length}])
  end
end