class CreateIcons < ActiveRecord::Migration
  def change
    create_table :icons do |t|
      t.string :name
#is_visible can be used as a check to hide/unhide
      t.boolean :is_visible, default: true
#video, user etc
      t.string :icon_type, default: "badge"
#url of icon
      t.string :icon_url

      t.integer :badges_count

      t.timestamps null: false
    end
  end
end
