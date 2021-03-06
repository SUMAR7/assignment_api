class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, unique: true, null: false

      t.timestamps
    end

    add_index :users, :username
  end
end
