class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :comment
      t.date :date_of_comment

      t.timestamps
    end
  end
end
