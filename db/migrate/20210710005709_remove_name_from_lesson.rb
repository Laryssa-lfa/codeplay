class RemoveNameFromLesson < ActiveRecord::Migration[6.1]
  def change
    remove_column :lessons, :name, :string
  end
end
