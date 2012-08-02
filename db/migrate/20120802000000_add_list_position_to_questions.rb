class AddListPositionToQuestions < ActiveRecord::Migration
  def self.up
    add_column "questions","list_position", :integer
  end

  def self.down
    remove_column "questions","list_position"
  end
end
