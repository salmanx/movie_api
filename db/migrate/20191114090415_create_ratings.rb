class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.references :movies
      t.references :users
      t.timestamps
    end
  end
end
