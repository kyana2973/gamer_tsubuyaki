class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :game_name
      t.string :thread_name

      t.timestamps
    end
  end
end
