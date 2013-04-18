class AddShaToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :sha, :string
  end
end
