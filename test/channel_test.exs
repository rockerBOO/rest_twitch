defmodule RestTwitch.ChannelsTest do
  use ExUnit.Case

  doctest RestTwitch.Channels

  setup do 
    RestTwitch.Request.start 
  end
end