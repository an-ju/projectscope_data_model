class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.integer :order
      t.string :event_type
      t.string :author
      t.timestamp :received_at
      t.text :data

      t.timestamps
    end
  end
end
