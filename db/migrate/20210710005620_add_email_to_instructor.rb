class AddEmailToInstructor < ActiveRecord::Migration[6.1]
  def change
    add_column :instructors, :email, :string
    add_index :instructors, :email, unique: true
  end
end
