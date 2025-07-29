class AddEmployeeIdToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :employee_id, :integer
    add_index :posts, :employee_id
    add_foreign_key :posts, :employees
  end
end
