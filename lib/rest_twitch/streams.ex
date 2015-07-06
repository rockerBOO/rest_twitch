defmodule RestTwitch.Streams do
  alias RestTwitch.Request
  import ExPrintf

  defmodule Stream do
    defstruct [
      :game,
      :viewers,
      :average_fps,
      :video_height,
      :created_at,
      :_id,
      channel: RestTwitch.Channels.Channel,
    ]
  end

  @doc """
  GET /streams/:channel/  Get stream object
  Gets a stream object if live.

  ## Examples
  RestTwitch.Streams.get("test_user1")
  nil
  """
  def get(channel) do
    # 2 response states!!
    "/streams/%s"
      |> sprintf([channel])
      |> Request.get_body!()
      |> Poison.decode!()
      |> Map.fetch!("stream")
  end

  @doc """
  GET /streams  Get stream object
  Gets a stream

  game      optional, string  Streams categorized under game.

  channel   optional  string  Streams from a comma separated list of channels.

  limit     optional  integer Maximum number of objects in array. Default is 25. Maximum is 100.

  offset    optional  integer Object offset for pagination. Default is 0.

  client_id optional  string  Only shows streams from applications of client_id.

  ## Examples
  RestTwitch.Streams.search(%{"game" => "Programming", "channel" => "rockerboo"})

  """
  def live(opts \\ %{}, cache \\ nil) do
    "/streams?%s"
      |> sprintf([URI.encode_query(opts)])
      |> Request.get_cache_decode!(cache)
      |> Map.fetch!("streams")
  end

  @doc """
  GET /streams/featured   Get a list of featured streams
  Get a list of featured streams

  limit   optional  integer   Maximum number of objects in array. Default is 25. Maximum is 100.
  offset  optional  integer   Object offset for pagination. Default is 0.

  ## Examples
  RestTwitch.Streams.featured(%{"limit" => 25})
  """
  def featured(opts, cache \\ nil) do
    "/streams/featured"
      |> Request.get_cache_decode!(cache)
  end

  @doc """
  GET /streams/summary  Get a summary of streams
  Get a summary of streams

  game  optional  string  Only show stats for the set game

  ## Examples
  RestTwitch.Streams.summary(%{"game" => "Half-Life 3"})
  """
  def summary(opts \\ %{}, cache \\ nil) do
    "/streams/summary?%s"
      |> sprintf([URI.encode_query(opts)])
      |> Request.get_cache_decode!(cache)
  end

  @doc """
  # Authenticated, required scope: user_read
  GET /streams/followed   Get a list of streams user is following
  Get a list of streams user is following

  limit   optional  integer   Maximum number of objects in array. Default is 25. Maximum is 100.
  offset  optional  integer   Object offset for pagination. Default is 0.

  ## Examples
  RestTwitch.Streams.followed(%{"limit" => 25})
  """
  def followed(opts \\ %{}, cache \\ nil) do
    "/streams/followed"
      |> sprintf([URI.encode_query(opts)])
      |> Request.get_cache_decode!(cache)
      |> Map.fetch!("streams")
  end
end