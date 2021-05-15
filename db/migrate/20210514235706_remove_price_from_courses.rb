class RemovePriceFromCourses < ActiveRecord::Migration[6.1]
  def change
    remove_column :courses, :price, :integer
  end
end
