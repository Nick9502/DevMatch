class UsersController < ApplicationController
    before_action :authenticate_user! # Authenticates user before any actions can occur.(Devise)
    
    def index
        
    end
    
    # GET to /users/:id
    def show
    @user = User.find( params[:id])    
    end
end