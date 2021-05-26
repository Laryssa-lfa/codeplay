class RemoveTimeFromLessons < ActiveRecord::Migration[6.1]
  def change
    remove_column :lessons, :time, :string
  end
end
