class ProfilesController < ApplicationController
   
   # GET to /users/:user_id/profile/new
   def new
        @profile = Profile.new
   end
   
   # POST to /users/:user_id/profile
   def create
      # Ensure that we have user who is filling out form.
      @user = User.find(params[:user_id] ) #Part of ActiveRecord.
      # Create profile linked to this specific user. Use with associations. profiles.build if has_many
      @profile = @user.build_profile(profile_params) 
      if @profile.save
         flash[:success] = "Profile Updated!"
         redirect_to user_path(params[:user_id])
      else
         render action: :new
      end
   end
   
   private
      # Whitelist so hackers cant add additional form fields.
      def profile_params
         params.require(:profile).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
      end
end