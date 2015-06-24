defmodule RestTwitch.Chat do
  alias RestTwitch.Request

  defmodule Emoticon do

    # "regex": "\:-?\(",
    # "images": [
    #   {
    #     "emoticon_set": null,
    #     "height": 18,
    #     "width": 24,
    #     "url": "http://static-cdn.jtvnw.net/jtv_user_pictures/chansub-global-emoticon-d570c4b3b8d8fc4d-24x18.png"
    #   },
    #   {
    #     "emoticon_set": 33,
    #     "height": 18,
    #     "width": 21,
    #     "url": "http://static-cdn.jtvnw.net/jtv_user_pictures/chansub-global-emoticon-c41c5c6c88f481cd-21x18.png"
    #   }
    # ]
    defstruct [
      :type,

    ]
  end
	# GET /chat/:channel 	Get links object to other chat endpoints
	#
	# GET /chat/emoticons 	Get list of every emoticon object

  @doc """
  GET /chat/:channel/badges   Get chat badges for channel

  ## Examples

  RestTwitch.Chat.badges("test_channel")

  """
  def badges(channel) do
    "/chat/%s/badges"
      |> Request.get_body!()
      |> Request.decode_json!()
  end

  @doc """
  GET /chat/emoticons   Get list of every emoticon object

  ## Currently responds 504

  ## Examples

  RestTwitch.Chat.emoticons()

  """
  def emoticons() do
    "/chat/emoticons"
      |> Request.get_body!()
      |> Request.decode_json!("emoticons", [RestTwitch.Chat.Emoticon])
  end
end