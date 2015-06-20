defmodule Channel do
  defstruct [
    :mature, 
    :status,
    :broadcaster_language,
    :display_name,
    :game,
    :delay,
    :language,
    :id,
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
    :followers
  ]
end

defmodule RestTwitch.Channels do
  alias RestTwitch.Request
  import ExPrintf
  # GET /channels/:channel   Get channel object
  # GET /channel  Get channel object
  # GET /channels/:channel/videos   Get channel's list of videos
  # GET /channels/:channel/follows  Get channel's list of following users
  # GET /channels/:channel/editors  Get channel's list of editors

  @doc """
  Get a channel object
  """
  def get(channel) do
    url = sprintf("/channels/%s", [channel])

    request_get(url)
  end

  @doc """
  Get the list of videos on the channel
  """
  def get(channel, "videos") do
    url = sprintf("/channels/%s/videos", [channel])
    request_get(url)
  end

  @doc """
  Get the list of following users on the channel
  """
  def get(channel, "follows") do
    url = sprintf("/channels/%s/follows", [channel])
    request_get(url)
  end

  @doc """
  Get the list of editors on the channel
  """
  def get(channel, "editors") do
    url = sprintf("/channels/%s/editors", [channel])
    request_get(url)
  end

  @doc """
  Get list of teams channel belongs to
  """
  def get(channel, "teams") do
    url = sprintf("/channels/%s/teams", [channel])
    request_get(url)
  end

  # PUT /channels/:channel  Update channel object
  # DELETE /channels/:channel/stream_key  Reset channel's stream key
  # POST /channels/:channel/commercial  Start a commercial on channel
  # GET /channels/:channel/teams  Get list of teams channel belongs to
  
  def get(channel, data) do
    url = sprintf("/channels/%s/videos", [channel])
    put(url, data)
  end

  def commerical(channel, length \\ 30) do
    url = sprintf("/channels/%s/commercial", [channel])
    post(url, "length=" <> length).body[:status]
  end

  def request_get(url) do
    Request.get!(url).body
  end

  def post(url, body) do 
    Request.post!(url, body)
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

    Request.post!(url, data)
  end


end