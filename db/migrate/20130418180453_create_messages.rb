class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :snap_shot_id
      t.string :text

      t.timestamps
    end
  end
end
