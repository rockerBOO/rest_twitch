defmodule RestTwitchTest do
  use ExUnit.Case

  setup do 
    RestTwitch.Request.start 
  end

  test "Get a channel object" do 
    status = RestTwitch.Channels.get("rockerboo")[:status]

    expected = "Elixir Twitch API development. Ask any questions =) "
  
    assert expected == status
  end
end
