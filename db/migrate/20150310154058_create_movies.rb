class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.belongs_to :studio, index: true
      t.integer :year

      t.timestamps null: false
    end
    add_foreign_key :movies, :studios
  end
end
