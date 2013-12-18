class CreatePriceChecks < ActiveRecord::Migration
  def change
    create_table :price_checks do |t|
      t.string :make
      t.string :model
      t.string :year
      t.string :price
      t.string :url

      t.timestamps
    end
  end
end
