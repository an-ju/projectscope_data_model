class CreateResources < ActiveRecord::Migration[5.1]
  def change
    create_table :resources do |t|
      t.string :name
      t.string :status
      t.timestamp :active_at
      t.text :meta

      t.timestamps
    end
  end
end
