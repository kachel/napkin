class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :project
      t.integer :user_id
    end
  end
end
