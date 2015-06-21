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
    sprintf("/users/%s", [user])
      |> Request.get_body
      |> Poison.decode!(as: User)
  end

  @doc """
  Authenticated, required scope: user_read

  Gets the logged in users object

  ## Example
  RestTwitch.Users.get(:user)
  """
  def get(:user) do
    "/user"
      |> Request.get_body
      |> Request.process_body("channels", %{"channels" => [RestTwitch.Channels.Channel]})
  end

  @doc """
  Authenticated, required scope: user_read

  GET /streams/followed   Get list of streams user is following

  limit   optional  integer   Maximum number of objects in array. Default is 25. Maximum is 100.

  offset  optional  integer   Object offset for pagination. Default is 0.
  
  ## Example

  # Does not work yet
  RestTwitch.users.streams_following()
  """
  def streams_following() do
    "/streams/followed"
      |> Request.get_body
      |> Request.process_body("streams", %{"streams" => [RestTwitch.Streams.Stream]})
  end

  @doc """
  Authenticated, required scope: user_read
  GET /videos/followed  Get list of videos belonging to channels user is following
  https://github.com/justintv/Twitch-API/blob/master/v3_resources/users.md#get-videosfollowed
  Gets the videos this user follows

  limit   optional  integer   Maximum number of objects in array. Default is 10. Maximum is 100.

  offset  optional  integer   Object offset for pagination. Default is 0.

  ## Example
  # Does not work yet
  RestTwitch.Users.videos_followed()
  """
  def videos_followed() do
    "/videos/followed"
      |> Request.get_body
      |> Request.process_body("videos", %{"videos" => [RestTwitch.Videos.Video]})
  end
end