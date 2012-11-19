class CreateHints < ActiveRecord::Migration
  def change
    create_table :hints do |t|
      t.string :author
      t.text :body

      t.timestamps
    end
  end
end
