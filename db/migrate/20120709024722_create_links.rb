class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.integer :click_count, default: 0
      t.timestamps
    end
  end
end
