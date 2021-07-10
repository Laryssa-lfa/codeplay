class AddNameToLesson < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :name, :string
    add_index :lessons, :name, unique: true
  end
end
