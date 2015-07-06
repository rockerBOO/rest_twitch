defmodule RestTwitch.Videos do
  import ExPrintf
  alias RestTwitch.Request

  defmodule Video do
  	defstruct [
      :title,
      :description,
      :broadcast_id,
      :status,
      :tag_list,
      :_id,
      :recorded_at,
      :game,
      :length,
      :preview,
      :url,
      :views,
      :broadcast_type,
      channel: %RestTwitch.Channels.Channel{},
  	]
  end


  @doc """
  GET /channels/:channel   Get channel object
  Get a channel object

  ## Examples

  RestTwitch.Channels.get("test_channel")
  """
  def top(opts \\ [], cache \\ nil) do
    "/videos/top?%s"
      |> sprintf([URI.encode_query(opts)])
      |> Request.get_cache_decode!(cache)
      |> Map.fetch!("videos")
  end

  @doc """
  GET /channels/:channel/videos   Get list of video objects belonging to channel

  """
  def channel(channel, opts \\ %{}, cache \\ nil) do
    "/channels/%s/videos?%s"
      |> sprintf([channel, URI.encode_query(opts)])
      |> Request.get_cache_decode!(cache)
      |> Map.fetch!("videos")
  end
end