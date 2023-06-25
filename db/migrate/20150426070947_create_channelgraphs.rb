class CreateChannelgraphs < ActiveRecord::Migration
  def change
    create_table :channelgraphs do |t|
      t.belongs_to :channel#, index: true
      t.belongs_to :video, index: true

      t.timestamps null: false
    end
    add_index :channelgraphs, [:channel_id, :video_id], unique: true
  end
end
