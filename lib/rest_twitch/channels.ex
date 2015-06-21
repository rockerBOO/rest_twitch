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
  """
  def get(channel) do
    url = sprintf("/channels/%s", [channel])

    Request.get_body(url)
      |> Request.process_response_body(:channels, Channel)
  end

  @doc """
  GET /channels/:channel/videos   Get channel's list of videos
  Get the list of videos on the channel
  """
  def get(channel, "videos") do
    url = sprintf("/channels/%s/videos", [channel])

    Request.get_body(url)
      |> Request.process_response_body(:videos, RestTwitch.Videos.Video)
  end

  @doc """
  GET /channels/:channel/follows  Get channel's list of following users
  Get the list of following users on the channel
  """
  # def get(channel, "follows") do
  #   url = sprintf("/channels/%s/follows", [channel])
  #   get_body(url)
  #     |> Request.process_response_body(:follows)
  # end

  @doc """
  GET /channels/:channel/editors  Get channel's list of editors
  Get the list of editors on the channel
  """
  # def get(channel, "editors") do
  #   url = sprintf("/channels/%s/editors", [channel])
  #   get_body(url)
  #     |> Request.process_response_body(:editors)
  # end

  @doc """
  Get list of teams channel belongs to
  """
  # def get(channel, "teams") do
  #   url = sprintf("/channels/%s/teams", [channel])
  #   get_body(url)
  #     |> Request.process_response_body(:teams)
  # end

  # PUT /channels/:channel  Update channel object
  
  @doc """
  PUT /channels/:channel  Update channel object
  Update channel object
  """
  def put(channel, data) do
    sprintf("/channels/%s/videos", [channel])
      |> Request.put(data)
  end

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