module GlobalConstants
 extend ActiveSupport::Concern

 SITE_NAME="MyShortFlicks"
#needed for getting trending stuffs
 VIDEO_TRENDING_NORMALIZER=1.5.freeze
 CHANNEL_TRENDING_NORMALIZER=1.5.freeze
#while form submission sanity check
 VALID_MOBILE_REGEX = /^[789]\d{9}$/
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 VALID_YOUTUBE_URL_REGEX = /(?:http|https|)(?::\/\/|)(?:www.|)(?:youtu\.be\/|youtube\.com(?:\/embed\/|\/v\/|\/watch\?v=|\/ytscreeningroom\?v=|\/feeds\/api\/videos\/|\/user\S*[^\w\-\s]|\S*[^\w\-\s]))([\w\-]{11})/
 VALID_VIMEO_URL_REGEX = /^(http\:\/\/|https\:\/\/)?(www\.)?(vimeo\.com\/)([0-9]+)$/
 VALID_DAILY_MOTION_URL_REGEX = /^.+dailymotion.com\/((video|hub)\/([^_]+))?[^#]*(#video=([^_&]+))?/
#sample set of sexes which a user can have, other takes care of all medical experimentation
 USER_SEX_MALE="male"
 USER_SEX_FEMALE="female"
 USER_SEX_OTHER="other"
 USER_SEX= [USER_SEX_MALE,USER_SEX_FEMALE,USER_SEX_OTHER]
#sample set of icons
 ICON_TYPE_REVIEW="review"
 ICON_TYPE_GENRE="genre"
 ICON_TYPE=[ICON_TYPE_REVIEW,ICON_TYPE_GENRE]

 CAST_ACTOR="actor"
 CAST_DIRECTOR="director"
 CAST_ACTRESS="actress"
 CAST_TYPE=[CAST_ACTOR,CAST_DIRECTOR,CAST_ACTRESS]

 VIDEO_PER_PAGE=10
 CHANNEL_PER_PAGE=10
 USER_PER_PAGE=10

 YOUTUBE_HOST="youtube.com"
 VIMEO_HOST="vimeo.com"
 PERMISSIBLE_VIDEO_HOST=[YOUTUBE_HOST,VIMEO_HOST]

 BAD_URL_EXCEPTION="bad url"
 UNKNOWN_EXCEPTION="technical error, please inform us"
 NON_PERMITTED_HOST_EXCEPTION="only videos from youtube and vimeo are accepted"

end
