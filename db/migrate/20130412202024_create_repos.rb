class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :name
      t.datetime :last_track_date

      t.timestamps
    end
  end
end
