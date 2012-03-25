class CreateAdverts < ActiveRecord::Migration
  def change
    create_table :adverts do |t|
      t.text :text
      t.references :user

      t.timestamps
    end
  end
end
