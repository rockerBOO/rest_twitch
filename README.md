RestTwitch
==========

RestTwitch is a Elixir Library for accessing the Twitch REST API. 

Open to all pull requests and contributions.

To start:

1. `mix deps.get`
2. `iex -S mix`


## Get a channel object

	iex>   RestTwitch.Channels.get("test_channel")
	%RestTwitch.Channels.Channel{_id: 6140842, _link: nil, background: nil,
	 banner: nil, broadcaster_language: nil, created_at: "2009-05-08T08:19:58Z",
	 delay: nil, display_name: "Test_channel", followers: 7, game: nil,
	 language: "en", logo: nil, mature: false, name: "test_channel", partner: false,
	 profile_banner: nil, profile_banner_background_color: nil,
	 status: "TESTING  TESTING   TESTING", updated_at: "2015-06-17T15:15:29Z",
	 url: "http://www.twitch.tv/test_channel", video_banner: nil, views: 87}

## Get a user object

	iex> RestTwitch.Users.get("test_user1")
	%RestTwitch.Users.User{_id: 22747064,
	 _links: %{"self" => "https://api.twitch.tv/kraken/users/test_user1"}, bio: nil,
	 created_at: "2011-06-02T20:04:03Z", display_name: "Test_user1",
	 logo: "http://static-cdn.jtvnw.net/jtv_user_pictures/test_user1-profile_image-ac0a2f0d39dda770-300x300.jpeg",
	 name: "test_user1", type: "user"}

## Get status of follow relationship between user and target channel

	iex> RestTwitch.Follows.follows("test_user1", "test_channel")
	"test_user1 is not following test_channel"

	iex> RestTwitch.Follows.follows("rockerboo", "dansgaming")
	%RestTwitch.Channels.Channel{_id: 7236692, _link: nil, background: nil,
	 banner: nil, broadcaster_language: "en", created_at: "2009-07-15T03:02:41Z",
	 delay: nil, display_name: "DansGaming", followers: 335128, game: "NothingElse",
	 language: "en",
	 logo: "http://static-cdn.jtvnw.net/jtv_user_pictures/dansgaming-profile_image-0ab2ab5e0abc0d3a-300x300.png",
	 mature: true, name: "dansgaming", partner: true,
	 profile_banner: "http://static-cdn.jtvnw.net/jtv_user_pictures/dansgaming-profile_banner-8c8c86fb8af8c27e-480.png",
	 profile_banner_background_color: "#f6f6f6", status: "Just Talking Guys <3",
	 updated_at: "2015-06-05T18:18:31Z", url: "http://www.twitch.tv/dansgaming",
	 video_banner: "http://static-cdn.jtvnw.net/jtv_user_pictures/dansgaming-channel_offline_image-b3b49cb22b2b6a7a-640x360.png",
	 views: 44543258}

## Get a user's list of followed channels

	iex> RestTwitch.Follows.get("test_user1", %{"direction" => "desc"})
	[%RestTwitch.Follows.Follow{_links: %{"self" => "https://api.twitch.tv/kraken/users/rockerboo/follows/channels/zmaskm"},
	  channel: %{"_id" => 32271832,
	    "_links" => %{"chat" => "https://api.twitch.tv/kraken/chat/zmaskm",
	      "commercial" => "https://api.twitch.tv/kraken/channels/zmaskm/commercial",
	      "editors" => "https://api.twitch.tv/kraken/channels/zmaskm/editors",
	      "features" => "https://api.twitch.tv/kraken/channels/zmaskm/features",
	      "follows" => "https://api.twitch.tv/kraken/channels/zmaskm/follows",
	      "self" => "https://api.twitch.tv/kraken/channels/zmaskm",
	      "stream_key" => "https://api.twitch.tv/kraken/channels/zmaskm/stream_key",
	      "subscriptions" => "https://api.twitch.tv/kraken/channels/zmaskm/subscriptions",
	      "teams" => "https://api.twitch.tv/kraken/channels/zmaskm/teams",
	      "videos" => "https://api.twitch.tv/kraken/channels/zmaskm/videos"},
	    "background" => nil, "banner" => nil, "broadcaster_language" => "en",
	    "created_at" => "2012-07-20T02:03:58Z", "delay" => nil,
	    "display_name" => "zMASKm", "followers" => 1411, "game" => "Dark Souls",
	    "language" => "en",
	    "logo" => "http://static-cdn.jtvnw.net/jtv_user_pictures/zmaskm-profile_image-563f34eb36114b78-300x300.png",
	    "mature" => true, "name" => "zmaskm", "partner" => false,
	    "profile_banner" => nil, "profile_banner_background_color" => nil,
	    "status" => "Revisiting Lordran || Metal and Dark Souls || #TeamPxL",
	    "updated_at" => "2015-06-05T18:15:52Z",
	    "url" => "http://www.twitch.tv/zmaskm",
	    "video_banner" => "http://static-cdn.jtvnw.net/jtv_user_pictures/zmaskm-channel_offline_image-83dd9ca35d97122c-640x360.png",
	    "views" => 33126}, created_at: "2015-03-19T23:22:00Z", notifications: false,
	  user: %RestTwitch.Users.User{_id: nil, _links: nil, bio: nil, created_at: nil,
	   display_name: nil, logo: nil, name: nil, type: nil}}, %RestTwitch.Follows.Follow{...}, ...]
