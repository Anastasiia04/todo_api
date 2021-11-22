class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :name, null: false
      t.references :task

      t.timestamps
    end
  end
end
