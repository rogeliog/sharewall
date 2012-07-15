class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.integer :click_count, default: 0
      t.string :title
      t.string :thumbnail_url
      t.string :provider_url
      t.string :provider_name
      t.string :type
      t.text :html
      t.text   :description
      t.timestamps
    end
  end
end
