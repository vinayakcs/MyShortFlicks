class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :from_user, index: true
      t.belongs_to :to_user, index: true
      t.datetime   :read_at

      t.text :content

      t.timestamps null: false
    end
  end
end
