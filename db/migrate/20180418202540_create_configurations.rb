class CreateConfigurations < ActiveRecord::Migration[5.1]
  def change
    create_table :configurations do |t|
      t.string :name
      t.text :value

      t.timestamps
    end
  end
end
