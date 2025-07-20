class AddFieldsToEmployee < ActiveRecord::Migration[8.0]
  def change
    add_column :employees, :has_passport, :boolean
    add_column :employees, :salary, :integer
    add_column :employees, :notes, :string
    add_column :employees, :birth_date, :date
    add_column :employees, :hire_date, :date
    add_column :employees, :gender, :string
  end
end
