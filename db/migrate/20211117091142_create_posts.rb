class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.string :ip_address, null: false

      t.references :user, null: false

      t.timestamps
    end
  end
end
