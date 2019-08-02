class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :name
      t.text :details
      t.float :cost
      t.boolean :completed, :default => false
      t.boolean :notifications, :default => true
      t.integer :notification_freq
      t.integer :notification_type
      t.datetime :sent_time, :default => Time.now
      t.integer :age
      t.integer :user_id
      t.integer :text_sent_count, :default => 0
      t.integer :email_sent_count, :default => 0
      t.timestamps
    end
  end
end
