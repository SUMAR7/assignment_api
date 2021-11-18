class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.text :comment, null: false
      t.string :owner_id, null: false

      t.bigint  :feedbackable_id, null: false
      t.string  :feedbackable_type, null: false

      t.timestamps
    end

    add_index :feedbacks, :owner_id
    add_index :feedbacks, %i[feedbackable_type feedbackable_id]
  end
end
