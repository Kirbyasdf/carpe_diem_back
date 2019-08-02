class Api::V1::UsersController < ApplicationController


def index
  @users = User.all
  render json: @users
end

def show
  @user = User.find(params[:id])
  byebug
  @user.goal.each {|g| g.age  = ((Time.current - @goal.created_at)/ 1.day).round}
  render json: @user
end


def create

@user = User.create!(name: params[:name], email: params[:email].downcase, number: params[:number], password: params[:password])

render json:@user
end

def update

  @user = User.find(params[:id])

  @user.feet = params[:feet]
  @user.inch = params[:inch]
  @user.height = params[:height]
  @user.diabetes = params[:diabetes]
  @user.age = params[:age]
  @user.alochol = params[:alochol]
  @user.health = params[:health]
  @user.education = params[:education]
  @user.exercise = params[:exercise]
  @user.health = params[:health]
  @user.weight = params[:weight]
  @user.race = params[:race]
  @user.income = params[:income]
  @user.work = params[:work]
  @user.relationship = params[:relationship]
  @user.gender = params[:gender]

  r = RestClient.get("https://api.blueprintincome.com/v1/longevity/calculate/jsonp/full?alcohol=#{@user.alochol}&callback=angular.callbacks._0&current_age=#{@user.age}&diabetes=#{@user.diabetes}&education=#{@user.education}&exercise=#{@user.exercise}&gender=#{@user.gender}&health=#{@user.health}&height=#{@user.height}&height_type=IMPERIAL&income=#{@user.income}&incomeStatus=#{@user.work}&marital_status=#{@user.relationship}&optIn=false&race=#{@user.race}&weight=#{@user.weight}&weight_type=IMPERIAL")


  r_string = r.body
  r_string.slice!(0, 20)
  hash = eval(r_string)
  life_exp = hash.first[1][:mean].ceil
  @user.life_exp = life_exp
  @user.tltl = @user.life_exp - @user.age

  @user.save
  render json:@user

end


def settings_change
  @user = User.find(params[:id])


  clean_num = params[:number]

  # clean_num = params[:number]
  # clean_num.scan.(/\d+/).join
  # clean_num[0] == "1" ? number[0] = "" : clean_num
  # clean_num unless clean_num.length != 10

  @user.update(email: params[:email], number: clean_num)
  @user.feet = params[:feet]
  @user.inch = params[:inch]
  @user.height = params[:height]
  @user.diabetes = params[:diabetes]
  @user.age = params[:age]
  @user.alochol = params[:alochol]
  @user.health = params[:health]
  @user.education = params[:education]
  @user.exercise = params[:exercise]
  @user.health = params[:health]
  @user.weight = params[:weight]
  @user.race = params[:race]
  @user.income = params[:income]
  @user.work = params[:work]
  @user.relationship = params[:relationship]
  @user.gender = params[:gender]


  r = RestClient.get("https://api.blueprintincome.com/v1/longevity/calculate/jsonp/full?alcohol=#{@user.alochol}&callback=angular.callbacks._0&current_age=#{@user.age}&diabetes=#{@user.diabetes}&education=#{@user.education}&exercise=#{@user.exercise}&gender=#{@user.gender}&health=#{@user.health}&height=#{@user.height}&height_type=IMPERIAL&income=#{@user.income}&incomeStatus=#{@user.work}&marital_status=#{@user.relationship}&optIn=false&race=#{@user.race}&weight=#{@user.weight}&weight_type=IMPERIAL")


  r_string = r.body
  r_string.slice!(0, 20)
  hash = eval(r_string)
  life_exp = hash.first[1][:mean].ceil
  @user.life_exp = life_exp
  @user.tltl = @user.life_exp - @user.age
  @user.save
  render json:@user
end


def user_note_toggle
  @user = User.find(params[:id])
  @user.update(note_toggle: params[:note_toggle])
  render json: @user
end


end
