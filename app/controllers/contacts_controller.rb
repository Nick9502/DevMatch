class ContactsController < ApplicationController
    def new
      @contact = Contact.new
    end
    def create 
      #Mass assigns params  
      @contact = Contact.new(contact_params) #{name: "Test", email: "Test", comments: "Test"}
      if @contact.save #If the contact was saved correctly.
         flash[:success] ="Message sent."
         redirect_to new_contact_path
      else
         # Joins eror messages together and displays them.
         flash[:danger] = @contact.errors.full_messages.join(", ") #[error1, error2] become joined
         redirect_to new_contact_path
      end
    end
    private #Secure Form Admission
      def contact_params 
         params.require(:contact).permit(:name, :email, :comments) #Whielists parameters
      end
end