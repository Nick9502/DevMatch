class ContactsController < ApplicationController
    def new
      @contact = Contact.new
    end
    def create 
      #Mass assigns params  
      @contact = Contact.new(contact_params) #{name: "Test", email: "Test", comments: "Test"}
      if @contact.save #If the contact was saved correctly.
         redirect_to new_contact_path, notice: "Message sent."
      else
         redirect_to new_contact_path, notice: "Error occured."
      end
    end
    private #Secure Form Admission
      def contact_params 
         params.require(:contact).permit(:name, :email, :comments) #Whielists parameters
      end
end