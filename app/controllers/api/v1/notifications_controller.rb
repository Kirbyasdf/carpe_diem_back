class Api::V1::NotificationsController < ApplicationController

def send_text

  @tltl = params[:tltl]
  @goalname = params[:goalName]
  @details = params[:goaldDetails]
  @years = params[:tltl]
  @days = (@years * 365)
  @hours = (@days * 24)
  @mins = (@hours * 60)
  @secs = (@mins * 60)

  client = Twilio::REST::Client.new(ENV["twilio_account_sid"], Figaro.env.twilio_auth_token)
  client.messages.create({from: Figaro.env.twilio_phone_number, to: "+1#{params[:number]}", body: "Reminder-> Name: #{@goalname}, Details: #{@details} you have #{params[:tltl]} years  or #{@days} days, #{@hours} hours, #{@mins} minutes, #{@secs} seconds"})
end


def note_toggle
  @goal = Goal.find(params[:id])
  @goal.update(notifications: params[:notifications])
  render json: @goal
end


def send_email

  Mailjet.configure do |config|
  config.api_key = Figaro.env.mail_jet_api_key
  config.secret_key = Figaro.env.mail_jet_secret_key
  config.api_version = "v3.1"

  end
  # byebug

  variable  = Mailjet::Send.create(messages: [{
      'From'=> {
        'Email'=> 'kirbyaugustus@gmail.com',
        'Name'=> 'Augustus'
      },
      'To'=> [
        {
          'Email'=> params[:email],
          'Name'=> params[:name]
        }
      ],
      'Subject'=> params[:title],
      'TextPart'=> "#{params[:details]} please note you have #{params{:tlt}} years left to live",
      'HTMLPart'=> '-Carpe Diem',
      'CustomID' => 'AppGettingStartedTest'
     }]
  )



  p variable.attributes['Messages']

end



def respond_text
  byebug
  response = Twilio::TwiML::MessagingResponse.new
  response.message do |message|
  message.body('Hello World!')
end
response.redirect('https://demo.twilio.com/welcome/sms/')

client = Twilio::REST::Client.new(ENV["twilio_account_sid"], Figaro.env.twilio_auth_token)
client.messages.create({from: Figaro.env.twilio_phone_number, to: "+1#{params[:number]}", body: "Reminder: Name #{@goalname}, Details: you have #{params[:tltl]} years    left"})

byebug

end

def send_notifcation

end


end
