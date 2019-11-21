class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.references :movie
      t.references :user
      t.timestamps
    end
  end
end
