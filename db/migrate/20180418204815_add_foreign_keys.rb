class AddForeignKeys < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :resource, foreign_key: true
    add_reference :configurations, :resource, foreign_key: true
    add_reference :resources, :project, foreign_key: true
    add_reference :activities, :project, foreign_key: true
    add_reference :activities, :user, foreign_key: true
  end
end
