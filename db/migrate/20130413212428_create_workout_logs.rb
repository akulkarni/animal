class CreateWorkoutLogs < ActiveRecord::Migration
  def change
    create_table :workout_logs do |t|
      t.integer :user_id
      t.string :feedback

      t.timestamps
    end
  end
end
