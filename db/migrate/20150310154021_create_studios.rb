class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
