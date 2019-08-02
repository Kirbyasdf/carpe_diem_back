class User < ApplicationRecord
  has_many :goals





def self.notes?
  @users_w_notes  = []
  self.all.each {|u|  u.note_toggle ? @users_w_notes  << u :  nil }
  goal_notes?(@users_w_notes)
end


def self.goal_notes?(users)
  @goals_w_notes  = []
  users.each do |u|
  u.goals.each {|g|  g.notifications ? @goals_w_notes << g : nil}
    end
  goal_sort(@goals_w_notes)
end

def self.goal_sort(goals)

  goals.each do |goal|
  case goal.notification_type
    when 1
    sort_text(goal)
    when 2
    sort_email(goal)
    when 3
    sort_email(goal)
    sort_text(goal)
   end
  end
end


def self.sort_text(goal)
  case goal.notification_freq
    when 1
    send_text(goal, 0)
    when 2
    send_text(goal, 90)
    when 3
    send_text(goal, 182)
    when 4
    send_text(goal, 365)
 end
end

def self.send_text(goal, time)

  if  ((Time.current - goal.sent_time)/ 1.day).round >= time



    client = Twilio::REST::Client.new(ENV["twilio_account_sid"], Figaro.env.twilio_auth_token)

    client.messages.create({
      from: Figaro.env.twilio_phone_number,
      to: "+1#{goal.user.number}",
      body: "You have #{goal.user.tltl} left to live , this is something you want to do , get it done Name:#{goal.name} Details:#{goal.details}"
      })

      goal.sent_time = Time.now
      # goal.text_sent_count += 1
 end
end



def self.sort_email(goal)
  case goal.notification_freq
    when 1
    send_email(goal, 0)
    when 2
    send_email(goal, 90)
    when 3
    send_email(goal, 182)
    when 4
    send_email(goal, 365)
  end
end



def self.send_email(goal, time)


  if  ((Time.current - goal.sent_time)/ 1.day).round >= time

      Mailjet.configure do |config|
      config.api_key = Figaro.env.mail_jet_api_key
      config.secret_key = Figaro.env.mail_jet_secret_key
      config.api_version = "v3.1"

      end

    sending  = Mailjet::Send.create(messages: [{
        'From'=> {
          'Email'=> 'kirbyaugustus@gmail.com',
          'Name'=> 'Augustus'
        },
        'To'=> [
          {
            'Email'=> goal.user.email,
            'Name'=> goal.user.name
          }
        ],
        'Subject'=> goal.name,
        'TextPart'=> "#{goal.details} please note you have #{goal.user.tltl} years left to live",
        'HTMLPart'=> '<h3>Dear passenger 1, welcome to <a href=\'https://www.mailjet.com/\'>Mailjet</a>!</h3><br />May the delivery force be with you!',
        'CustomID' => 'AppGettingStartedTest'
       }]
    )
    goal.sent_time = Time.now
    # goal.text_sent_count += 1

    p "*" * 15
    p sending.attributes['Messages']
    p "*" * 15

  end

#
end

end
