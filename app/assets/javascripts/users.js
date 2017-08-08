/* global $, Stripe */

//Document ready.
$(document).on('turbolinks:load', function(){
  var theForm = $('#pro_form')
  var submitBtn = $('#form-signup-btn');
  
  //Set Stripe public key.
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content')) //Grabs content from meta tag in app.html
  
  //When user clicks for sumbit btn,
  submitBtn.click(function(event){
    //prevent default submission behavior.
    event.preventDefault();
    //collect the credit card fields.
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
    //Send the card info to Stripe.
    Stripe.createToken({
      number: ccNum,
      cvc: cvcNum,
      exp_month: expMonth,
      exp_year: expYear
    }, stripeResponseHandler);
  });
  
  
  
  //Stripe will return card token.
  //Inject card token as hidden fields into form.
  //submit forms to our Rails app.
    
});
