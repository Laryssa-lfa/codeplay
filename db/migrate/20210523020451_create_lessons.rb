class CreateLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :lessons do |t|
      t.string :name
      t.text :content
      t.string :time

      t.timestamps
    end
  end
end
