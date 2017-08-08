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
    //Change text to processing and disable button so user can wait.
    submitBtn.val("Processing").prop('disabled', true)
    
    //collect the credit card fields.
    var ccNum = $('#card_number').val(),
        cvcNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
        
    //Use StripeJS library to check for card errors.
    var error = false;
    
    //Validate card number
    if (!Stripe.card.validateCardNumber(ccNum)){
      error = true;
      alert('The credit card number appears to be invalid.')
    } 
    //Validate CVC Number
    if (!Stripe.card.validateCVC(cvcNum)){
      error = true;
      alert('The CCV number appears to be invalid.')
    } 
    //Validate Expiration Date
    if (!Stripe.card.validateExpiry(expMonth,expYear)){
      error = true;
      alert('The expiration date appears to be invalid.')
    } 
    if (error) {
      //If there are card errors, don't send to Stripe.
      submitBtn.prop('disabled', false).val("Sign Up");
    } else {
      //Send the card info to Stripe.
      Stripe.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_year: expYear
      }, stripeResponseHandler);
    }
    return false;
  });
  
  //Stripe will return card token.
  function stripeResponseHandler(status, response){
    var token = response.id; // Get token from the response
    
    //Inject card token as hidden fields into form.
    theForm.append($('<input type="hidden" name="user[stripe_card_token]">').val(token) );
    
    //submit forms to our Rails app.
    //Javascript stores it in array. Must grab 0th index(only index) which is our form
    theForm.get(0).submit(); 
  }
});
