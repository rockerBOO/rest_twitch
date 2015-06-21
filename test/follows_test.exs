defmodule RestTwitch.FollowsTest do
  use ExUnit.Case

  doctest RestTwitch.Follows

  setup do 
    RestTwitch.Request.start 
  end
end