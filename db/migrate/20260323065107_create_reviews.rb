class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.string :reviewer_name
      t.text :body
      t.decimal :rating
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
