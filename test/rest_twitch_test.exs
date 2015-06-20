defmodule RestTwitchTest do
  use ExUnit.Case

  setup do 
    RestTwitch.Request.start 
  end

  test "Get a channel object" do 
    channel_info = RestTwitch.Channels.get("rockerboo")

    # IO.inspect channel_info    

    status = channel_info[:name]

    expected = "rockerboo"
  
    assert expected == status
  end

  test "Get a list of videos on the channel" do 
    channel_info = RestTwitch.Channels.get("lirik", "videos")

    IO.inspect channel_info
  end
end
