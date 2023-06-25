class CreateCasts < ActiveRecord::Migration
  def change
    create_table :casts do |t|
      t.belongs_to :video#, index: true
      t.belongs_to :assignee, index: true
      t.belongs_to :assignor, index: true
      t.string :cast_type
      t.boolean :assignee_approved
      t.integer :votes_count
      t.timestamps null: false
    end
    add_index :casts, [:video_id, :assignee_id, :cast_type], unique: true
  end
end
