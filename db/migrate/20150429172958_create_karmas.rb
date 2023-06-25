class CreateKarmas < ActiveRecord::Migration
  def change
    create_table :karmas do |t|
      t.belongs_to :user, index: true
#which event ? subscription crosses 1200 , or added video
      t.string :event_type
#how much value, select sum(event_value) where user_id should be reputation point of user
      t.integer :event_value

      t.timestamps null: false
    end
   add_index :karmas, [:user_id, :event_type], unique: true
  end
end
