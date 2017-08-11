class UsersController < ApplicationController
    before_action :authenticate_user! # Authenticates user before any actions can occur.(Devise)
    
    def index
       @users=User.includes(:profile) # Less queries that User.all. Faster
    end
    
    # GET to /users/:id
    def show
    @user = User.find( params[:id])    
    end
end