class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.belongs_to :user, index: true
      t.belongs_to :video, index: true
      t.belongs_to :icon, index: true
      t.timestamps null: false
    end
    add_index :badges, [:user_id,:video_id,:icon_id], unique: true
  end
end
