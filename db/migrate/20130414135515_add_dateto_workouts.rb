class AddDatetoWorkouts < ActiveRecord::Migration
  def up
    add_column :workouts, :date, :string
  end

  def down
    remove_column :workouts, :date
  end
end
