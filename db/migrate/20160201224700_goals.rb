class Goals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.boolean :visible, default: false
      t.boolean :completed, null: false
      t.string :name, null: false
    end


  end
end
