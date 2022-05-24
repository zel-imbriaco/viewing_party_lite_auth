# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(session[:user_id])
    @parties = []
    Party.all.each do |party|
      party.attendees.each do |attendee|
        if party.user_id == @user.id || attendee.user_id == @user.id
          @parties << party
        end
      end 
    end 
    movie_ids = @parties.map { |party| party.movie_id }
    @movies = MovieFacade.multiple_movies(movie_ids)
  end

  def login; end

  def new; end

  def create
    if new_user_params[:name] == ""
      redirect_to "/users/new", alert: "Please enter your name."
    elsif new_user_params[:email] == ""
      redirect_to "/users/new", alert: "Please enter your desired email address."
    elsif new_user_params[:password] == ""
      redirect_to "/users/new", alert: "Please enter a password."
    elsif new_user_params[:password] != new_user_params[:password_confirmation]
      redirect_to "/users/new", alert: "Your passwords must match."
    else
      User.create(new_user_params)
      @user = User.where(email: new_user_params[:email]).first
      session[:user_id] = @user.id
      redirect_to dashboard_path
    end
  end
    
  def discover
    @user = User.find(params[:id])
  end

  private

  def new_user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

end
