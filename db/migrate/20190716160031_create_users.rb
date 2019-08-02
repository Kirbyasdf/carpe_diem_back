class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      #tltl = time left to live
      t.float :tltl
      t.boolean :note_toggle, :default => true
      t.string :number
      t.integer :life_exp
      t.string :email
      t.string :password
      t.string :password_digest
      t.string :gender
      t.string :diabetes
      t.integer :age
      t.string :alochol
      t.string :education
      t.string :exercise
      t.string :health
      t.integer :height
      t.integer :feet
      t.integer :inch
      t.integer :weight
      t.string :race
      t.string :income
      t.string :work
      t.string :relationship
      t.timestamps
    end
  end
end
