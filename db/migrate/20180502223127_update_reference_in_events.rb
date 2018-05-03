class UpdateReferenceInEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :resource_id
    add_reference :events, :project, foreign_key: true
  end
end
