class AddApiKey < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :access_token, null: false
      t.string :client_id, null: false
      t.integer :user_id, null: false
    end
  end
end
