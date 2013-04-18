class ChangeRawAndHtmlInWorkouts < ActiveRecord::Migration
  def up
    change_column :workouts, :raw, :text
    change_column :workouts, :html, :text
  end

  def down
    change_column :workouts, :raw, :string
    change_column :workouts, :html, :string
  end
end
