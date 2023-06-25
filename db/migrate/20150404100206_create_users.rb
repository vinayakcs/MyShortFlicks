class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

#compose url from urltoken+firstname
      t.string :url_token
#user email, got from fb or g+
      t.string :email
#this is for user session control, a salt like token must go here (dynamic)
      t.string :remember_token

      t.string :first_name
      t.string :last_name

      t.string :gender

      t.string :quote, default: "Give me a museum and I'll fill it."

#reputation points
      t.integer :karma, default: 0
#may come in handy for karma points
      t.integer :comments_count, default: 0
      t.integer :votes_count, default: 0
#subscribed channels
      t.integer :subscriptions_count, default: 0
#number of badges awarded
      t.integer :badges_count, default: 0
#number of videos shared
      t.integer :videos_count, default: 0
#for number of channels managed
      t.integer :channels_count, default: 0
#for views
      t.integer :impressions_count, default: 0
#for unreadmessages
      t.integer :unread_msg_count, default:0
#for cast approval 
      t.integer :cast_approval_count, default:0
#profile image
      t.string :profile_image_url
#user description
      t.text   :bio

      t.timestamps null: false
    end

    add_index :users, :first_name,name: "search_user_name_first_index", length: 10
    add_index :users, :last_name,name: "search_user_name_last_index", length: 10
    add_index :users, :url_token, name: "user_index_url_token", unique: true

  end
end
