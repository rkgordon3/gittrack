class CreateTrackings < ActiveRecord::Migration
  def change
    create_table :trackings do |t|

      t.timestamps
    end
  end
end
