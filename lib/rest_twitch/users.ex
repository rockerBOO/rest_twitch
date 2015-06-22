# DONEish
defmodule RestTwitch.Users do
  alias RestTwitch.Request 
  import ExPrintf

  defmodule User do
    defstruct [
      :type, 
      :name,
      :created_at,
      :_links,
      :logo,
      :_id,
      :display_name,
      :bio
    ]
  end

  @doc """
  GET /users/:user  Get user object

  ## Example
      iex> RestTwitch.Users.get("nimolo00")
      %RestTwitch.Users.User{_id: 15255898,
       _links: %{"self" => "https://api.twitch.tv/kraken/users/nimolo00"},
       bio: "Enter your text here.", created_at: "2010-09-04T04:58:51Z",
       display_name: "Nimolo00",
       logo: "http://static-cdn.jtvnw.net/jtv_user_pictures/nimolo00-profile_image-e93f42babc1380a2-300x300.png",
       name: "nimolo00", type: "user"}

  """
  def get(user) do
    "/users/%s"
      |> sprintf([user])
      |> Request.get_body()
      |> Poison.decode!(as: User)
  end

  @doc """
  # Authenticated, required scope: user_read

  Gets the logged in users object

  ## Example
  OAuth2.AccessToken.new(%{
  "token_type" => "OAuth ", 
  "access_token" => System.get_env("TWITCH_ACCESS_TOKEN")
  }, OAuth2.Twitch.new()) |> 
  
  RestTwitch.Users.get(token)
  """
  def get(token) do
    "/user"
      |> Request.get_body(token)
      |> Request.process_body("channels", %{"channels" => [RestTwitch.Channels.Channel]})
  end

  @doc """
  # Authenticated, required scope: user_read

  GET /streams/followed   Get list of streams user is following

  limit   optional  integer   Maximum number of objects in array. Default is 25. Maximum is 100.

  offset  optional  integer   Object offset for pagination. Default is 0.
  
  ## Example

  OAuth2.AccessToken.new(%{
  "token_type" => "OAuth ", 
  "access_token" => System.get_env("TWITCH_ACCESS_TOKEN")
  }, OAuth2.Twitch.new()) |> 
  
  RestTwitch.Users.streams_following(token, %{"limit" => 25})
  """
  def streams_following(token, opts \\ %{}) do
    "/streams/followed"
      |> Request.get_body(token, opts)
      # |> Request.process_body("streams", %{"streams" => [RestTwitch.Streams.Stream]})
  end

  @doc """
  # Authenticated, required scope: user_read

  GET /videos/followed  Get list of videos belonging to channels user is following
  https://github.com/justintv/Twitch-API/blob/master/v3_resources/users.md#get-videosfollowed
  Gets the videos this user follows

  limit   optional  integer   Maximum number of objects in array. Default is 10. Maximum is 100.

  offset  optional  integer   Object offset for pagination. Default is 0.

  ## Example

  token = OAuth2.AccessToken.new(%{
  "token_type" => "OAuth ", 
  "access_token" => System.get_env("TWITCH_ACCESS_TOKEN")
  }, OAuth2.Twitch.new())
  
  RestTwitch.Users.videos_followed(token)
  """
  def videos_followed(token) do
    "/videos/followed"
      |> Request.get_body(token)
      # |> Request.process_body("videos", %{"videos" => [RestTwitch.Videos.Video]})
  end
end