class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :channel#, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_index :subscriptions, [:channel_id, :user_id], unique: true
  end
end
