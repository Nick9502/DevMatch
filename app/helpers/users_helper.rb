module UsersHelper #Helper files(Modules) aware of variables we write in controller.
   def job_title_icon
       if @user.profile.job_title == "Developer"
           "<i class='fa fa-code'></i>".html_safe #html_safe needed to inject into html document
       elsif @user.profile.job_title == "Entrepreneur"
           "<i class='fa fa-lightbulb-o'></i>".html_safe #html_safe needed to inject into html document
       elsif @user.profile.job_title == "Investor"
           "<i class='fa fa-dollar'></i>".html_safe #html_safe needed to inject into html document
       end
   end
end