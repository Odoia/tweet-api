class CreateFollow < ActiveRecord::Migration[6.0]
  def change
    create_table :followers do |t|
      t.bigint :follow_user_id
      t.references :user

      t.timestamps
    end
  end
end
