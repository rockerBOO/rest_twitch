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

    Request.request_get(url)
      |> Request.process_response_body("channels", Channel)
  end

  @doc """
  Get the list of videos on the channel
  """
  def get(channel, "videos") do
    url = sprintf("/channels/%s/videos", [channel])

    Request.request_get(url)
      |> Request.process_response_body("videos", RestTwitch.Videos.Video)
  end

  @doc """
  Get the list of following users on the channel
  """
  # def get(channel, "follows") do
  #   url = sprintf("/channels/%s/follows", [channel])
  #   request_get(url)
  #     |> Request.process_response_body("follows")
  # end

  @doc """
  Get the list of editors on the channel
  """
  # def get(channel, "editors") do
  #   url = sprintf("/channels/%s/editors", [channel])
  #   request_get(url)
  #     |> Request.process_response_body("editors")
  # end

  @doc """
  Get list of teams channel belongs to
  """
  # def get(channel, "teams") do
  #   url = sprintf("/channels/%s/teams", [channel])
  #   request_get(url)
  #     |> Request.process_response_body("teams")
  # end

  # PUT /channels/:channel  Update channel object
  # DELETE /channels/:channel/stream_key  Reset channel's stream key
  # POST /channels/:channel/commercial  Start a commercial on channel
  # GET /channels/:channel/teams  Get list of teams channel belongs to
  
  def get(channel, data) do
    url = sprintf("/channels/%s/videos", [channel])
    Request.put(url, data)
  end

  def commerical(channel, length \\ 30) do
    url = sprintf("/channels/%s/commercial", [channel])
    Request.post(url, "length=" <> length).body[:status]
  end
end