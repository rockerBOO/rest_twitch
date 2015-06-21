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
    url = sprintf("/channels/%s", [channel])

    Request.get_body(url)
      |> Request.process_body(Channel)
  end

  @doc """
  GET /channels/:channel/videos   Get channel's list of videos
  Get the list of videos on the channel
  
  limit       optional  integer  Maximum number of objects in array. Default is 10. Maximum is 100.

  offset      optional  integer  Object offset for pagination. Default is 0.

  broadcasts  optional  bool     Returns only broadcasts when true. Otherwise only highlights are returned. Default is false.

  hls         optional  bool     Returns only HLS VoDs when true. Otherwise only non-HLS VoDs are returned. Default is false.

  ## Examples
  RestTwitch.Channels.videos("test_channel", %{"broadcasts" => false, "hls" => false})
  """
  def videos(channel, opts \\ %{}) do
    query = URI.encode_query(opts)
    url = sprintf("/channels/%s/videos?%s", [channel, query])

    Request.get_body(url)
      |> Request.process_body("videos", %{"videos" => [RestTwitch.Videos.Video]})
  end

  @doc """
  GET /channels/:channel/follows  Get channel's list of following users
  Get the list of following users on the channel

  limit      optional  integer  Maximum number of objects in array. Default is 25. Maximum is 100.

  offset     optional  integer  Object offset for pagination. Default is 0.

  direction  optional  string   Creation date sorting direction. Default is desc. Valid values are asc and desc.
  
  ## Examples
  RestTwitch.Channels.followers("test_user1", %{"direction" => "desc"})
  """
  def followers(channel, opts \\ %{}) do
    query = URI.encode_query(opts)
    url = sprintf("/channels/%s/follows?%s", [channel, query])

    Request.get_body(url)
      |> Request.process_body("follows", %{"follows" => [RestTwitch.Follows.Follow]})
  end

  @doc """
  Authenticated, required scope: channel_read
  GET /channels/:channel/editors  Get channel's list of editors
  Get the list of editors on the channel

  ## Examples
  RestTwitch.Channels.followers("test_user1", %{"direction" => "desc"})
  """
  def editors(channel) do
    url = sprintf("/channels/%s/editors", [channel])
    Request.get_body(url)
      |> Request.process_body("users", %{"users" => [RestTwitch.Users.User]})
  end

  @doc """
  Get list of teams channel belongs to

  ## Examples
  RestTwitch.Channels.teams("test_user1")
  """
  def teams(channel) do
    url = sprintf("/channels/%s/teams", [channel])
    Request.get_body(url)
      |> Request.process_body("teams", %{"teams" => [RestTwitch.Teams.Team]})
  end

  # PUT /channels/:channel  Update channel object
  
  @doc """
  PUT /channels/:channel  Update channel object
  Update channel object
  """
  # def put(channel, data) do
  #   sprintf("/channels/%s/videos", [channel])
  #     |> Request.put(data)
  # end

  @doc """
  POST /channels/:channel/commercial  Start a commercial on channel
  Start a commercial on channel
  length = length of commerical
  """
  def commerical(channel, length \\ 30) do
    sprintf("/channels/%s/commercial", [channel])
      |> Request.post("length=" <> length)
  end
end