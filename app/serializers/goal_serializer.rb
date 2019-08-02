class GoalSerializer < ActiveModel::Serializer
  belongs_to :user
  attributes :id, :name, :details, :cost, :completed, :age, :created_at, :notification_freq, :notification_type, :notifications, :sent_time
end
