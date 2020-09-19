class CreateTweet < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :message 
      t.references :user

      t.timestamps
    end
  end
end
