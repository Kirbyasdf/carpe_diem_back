class UserSerializer < ActiveModel::Serializer
  has_many :goals
  attributes :id, :name, :tltl, :email, :gender, :diabetes, :age, :alochol, :education, :exercise, :health, :height, :weight, :race, :income, :work, :relationship, :life_exp, :number, :note_toggle
end
