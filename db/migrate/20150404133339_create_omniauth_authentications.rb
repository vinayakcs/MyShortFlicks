class CreateOmniauthAuthentications < ActiveRecord::Migration
  def change
    create_table :omniauth_authentications do |t|
      t.belongs_to :user, index: true

      t.string :provider
      t.string :uid
      t.string :url

      t.timestamps null: false
    end
    add_index :omniauth_authentications, [:uid, :provider], unique: true
  end
end
