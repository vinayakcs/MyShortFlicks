class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.belongs_to :user, index: true
#url=url_token+title
      t.string :url_token

      t.string :title
      t.text :description
      t.string :image_url
      t.integer :subscriptions_count, default: 0
      t.integer :videos_count, default: 0

      t.timestamps null: false
    end

    add_index :channels, :title, name: "channel_title_index", length: 10
  end
end
