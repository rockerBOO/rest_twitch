defmodule RestTwitch.Subscriptions do
# {
#       "_id": "88d4621871b7274c34d5c3eb5dad6780c8533318",
#       "user": {
#         "_id": 38248673,
#         "logo": null,
#         "type": "user",
#         "bio": "I'm testuser",
#         "created_at": "2012-12-06T00:32:36Z",
#         "name": "testuser",
#         "updated_at": "2013-02-06T21:27:46Z",
#         "display_name": "testuser",
#         "_links": {
#           "self": "https://api.twitch.tv/kraken/users/testuser"
#         }
#       },
#       "created_at": "2013-02-06T21:33:33Z",
#       "_links": {
#         "self": "https://api.twitch.tv/kraken/channels/test_channel/subscriptions/testuser"
#       }
#     },	
  defmodule Subscription do
    defstruct [
      :_id,
      
      :created_at,
      # user: %RestTwitch.Users.User{},
      user: RestTwitch.Users.User.__struct__
    ]
  end
end