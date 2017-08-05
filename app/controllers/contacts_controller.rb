class ContactsController < ApplicationController
    
    # GET request to /contact-us
    # Show new contact form
    def new
      @contact = Contact.new
    end
    
    # POST request /contacts
    def create 
      #Mass assignment of form fields into Contact object.
      @contact = Contact.new(contact_params) #{name: "Test", email: "Test", comments: "Test"}
      # Save Contact object to database.
      if @contact.save # If the contact was saved correctly.
         # Store form fields via parameters, into variables.
         name = params[:contact][:name]
         email = params[:contact][:email]
         body = params[:contact][:comments]
         # Plug variables into Contact Mailer email method and send email.
         ContactMailer.contact_email(name, email, body).deliver
         # Store success message in flash hash.
         # and redirect to the new action.
         flash[:success] ="Message sent."
         redirect_to new_contact_path
      else
         # If Contact object doesn't save
         # store error in flash hash.
         # Joins eror messages together and displays them.
         flash[:danger] = @contact.errors.full_messages.join(", ") #[error1, error2] become joined
         redirect_to new_contact_path
      end
    end
    
    # To collect data from form, we need to use
    # strong parameters and whitelist the form fields.
    private #Secure Form Admission
      def contact_params 
         params.require(:contact).permit(:name, :email, :comments) 
      end
end