class CreatePoems < ActiveRecord::Migration
  def change
    create_table :poems do |t|
      t.text :title
      t.string :poem

      t.timestamps null: false
    end
  end
end
