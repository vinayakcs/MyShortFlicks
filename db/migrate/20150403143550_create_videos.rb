class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
#owner userid
      t.belongs_to :user
#url_token is random unique id, its suffixed with title to create url
      t.string :url_token
#youtube,vimeo etc urls
      t.string :video_url
#video thumb image url
      t.string :video_thumbnail_url
#video average review score
      t.integer :reputation, default: 0

#video visibility control DELETE
#      t.boolean :is_visible, default: true

#video visibility control and also scheduling publication ; set default to current time in model
      t.datetime :published_at

#whats the publication time for featured videos in featured channel
      t.datetime :featured_at
#this field is used to check whether the video is claimed by the rightful owner
      t.datetime :claimed_at 
#video is contain adult content
      t.boolean :is_nsfw, default: false
#video title
      t.string :title
#video description
      t.text :description
#number of times video is shared
      t.integer :channels_count, default: 0
#video viewcount
      t.integer :impressions_count, default: 0
#video comments count
      t.integer :comments_count, default: 0
#gets total number of badges awarded to videos in domain, can be used to get trending categories
      t.integer :badges_count, default: 0
#video url_id is a unique referer in video hosting services needed for embedding videos
      t.string :video_urlid
#video duration as obtained from hosting service api
      t.string :duration
      t.timestamps null: false
    end
#for searching title
    add_index :videos, :title, name: "searching_title_index", length: 10
#for searching description
    add_index :videos, :description, name: "searching_description_index", length: 10
# review score is a good candidate for index, but since its a high freq update param, table re-index on everyupdate may happen, which is costly. So no index for that.


  end
end
