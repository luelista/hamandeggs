class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :chapter
      t.string :dispid
      t.text :question
      t.text :correctanswer
      t.text :wronganswer1
      t.text :wronganswer2
      t.text :wronganswer3

      t.timestamps
    end
  end
end
