class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string :raw
      t.string :html

      t.timestamps
    end
  end
end
