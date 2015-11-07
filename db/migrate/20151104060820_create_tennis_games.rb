class CreateTennisGames < ActiveRecord::Migration
  def change
    create_table :tennis_games do |t|

      t.timestamps null: false
    end
  end
end
