class AddForeignKeys < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :events, :resources
    add_foreign_key :configurations, :resources
    add_foreign_key :resources, :projects
    add_foreign_key :activities, :projects
    add_foreign_key :activities, :users
  end
end
