class CreateScreenshots < ActiveRecord::Migration
  def change
    create_table :screenshots do |t|
      t.string :screenshot_image
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
