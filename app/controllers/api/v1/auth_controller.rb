class Api::V1::AuthController < ApplicationController

  def login
    @user = User.all.find_by(email: params[:email].downcase)
    if @user

    @image = params[:image]

      require 'uri'
      require 'net/http'
      require 'json'


    url = URI("http://api.kairos.com/verify")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Post.new(url)
    request["app_id"] = Figaro.env.face_id
    request["app_key"] = Figaro.env.face_key
    request["Content-Type"] = 'application/json'
    request.body = "{\n\t\"image\": \"#{@image}\",\n\t\"gallery_name\": \"asdf\",\n\t\"subject_id\": \"#{@user.email}\"\n}"



    @res = http.request(request)
    @response = @res.read_body
    puts "*" * 100
    puts @response
    puts "*" * 100
    @hash = eval(@res.read_body)
    @results = @hash.first[1].first.first[1].first[1]

    @error = {message: false}
    render json: (@results > 0.65 ) ? @user : @error
else
  render json: {error: "No User Found"}
   end
end



  def image_cap
  @image = params[:imageSrc]
  @email = params[:email]

    puts "*" * 100

    require 'uri'
    require 'net/http'
    require 'json'


  url = URI("http://api.kairos.com/enroll")

  http = Net::HTTP.new(url.host, url.port)

  request = Net::HTTP::Post.new(url)
  request["app_id"] = Figaro.env.face_id
  request["app_key"] = Figaro.env.face_key
  request["Content-Type"] = 'application/json'
  request.body = "{\n\t\"image\": \"#{@image}\",\n\t\"gallery_name\": \"asdf\",\n\t\"subject_id\": \"#{@email}\"\n}"


  res = http.request(request)
  @response = res.read_body
  puts "*" * 100
  puts @response
  puts "*" * 100

  render json: @response


  end



end
