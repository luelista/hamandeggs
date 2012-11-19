class CreateFaches < ActiveRecord::Migration
  def change
    create_table :faches do |t|
      t.references :user
      t.references :question
      t.integer :fach

      t.timestamps
    end
    add_index :faches, :user_id
    add_index :faches, :question_id
  end
end
