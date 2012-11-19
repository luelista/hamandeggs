class AddExamtypeToUser < ActiveRecord::Migration
  def change
    add_column :users, :exam_type, :string
  end
end
