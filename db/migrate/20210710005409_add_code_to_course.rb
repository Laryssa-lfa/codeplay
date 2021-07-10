class AddCodeToCourse < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :code, :string
    add_index :courses, :code, unique: true
  end
end
