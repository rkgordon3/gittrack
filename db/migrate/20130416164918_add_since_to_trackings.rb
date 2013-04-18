class AddSinceToTrackings < ActiveRecord::Migration
  def change
    add_column :trackings, :since, :datetime
  end
end
