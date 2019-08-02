Rails.application.routes.draw do
  namespace :api do
   namespace :v1 do
     resources :goals, :users

     post "/login", to: "auth#login"
     patch '/status', to: 'goals#goals_status'
     patch '/updateuser', to: 'users#settings_change'
     post "/sendtext", to: 'notifications#send_text'
     patch '/notetoggle', to:"notifications#note_toggle"

     patch '/usernotetoggle', to: "users#user_note_toggle"

     get '/respondtext', to:'notifications#respond_text'

     post "/sendemail", to: "notifications#send_email"

     post "imgecap", to: "auth#image_cap"

   end
 end
end
