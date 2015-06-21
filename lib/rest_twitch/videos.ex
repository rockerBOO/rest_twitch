defmodule RestTwitch.Videos do
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

  def process_videos_list(body) do
    Poison.decode!(body, 
      as: %{"videos" => [Video]})
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end