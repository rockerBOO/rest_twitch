defmodule RestTwitch.Chat do
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
	# GET /chat/:channel/badges 	Get chat badges for channel
	# GET /chat/emoticons 	Get list of every emoticon objectz
	def get(channel) do

  end

  def get(channel, "badges") do

  end

  def get("emoticons") do
    "/chat/emoticons"
      |> Request.request_get
      |> Request.process_response_body("channels", RestTwitch.Chat.Emoticon)
  end
end