class AddColumnToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :deadline, :datetime, null: false
    add_column :tasks, :priority, :integer, null: false
    add_column :tasks, :status, :integer, null: false
  end
end
