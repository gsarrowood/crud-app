
// Wait for the DOM to be ready
$(document).ready(function() {
  // Initialize form validation on the registration form.
  // It has the name attribute "registration"
  $("#newPersonForm").validate({
    // Specify validation rules
    rules: {
      // The key name on the left side is the name attribute
      // of an input field. Validation rules are defined
      // on the right side
      firstName:     { required:true,minlength:1,maxlength:50},
      lastName:      { required:true,minlength:1,maxlength:50},
      emailAddress:  { required:true,minlength:1,maxlength:50,email:true},
      streetAddress: { required:true,minlength:1,maxlength:50},
      city:          { required:true,minlength:1,maxlength:50},
      state:         { required:true,minlength:2,maxlength:2},
      zipCode:       { required:true,minlength:5,maxlength:5}
    },
    // Specify validation error messages
    messages: {
      firstName:     "Client name is required with maximum length of 50",
      lastName:      "Client name is required with maximum length of 50",
      emailAddress:  {
			email:"Website is required with maximum length of 50",
			required:"Email Address is required with a maximum length of 50" 
		},
      streetAddress: "Street address is required with maximum length of 50",
      city:          "City is required with maximum length of 50",
      state:         "State is required with length 2",
      zipCode:       "Zip code is required with length 5"
    },
    // Make sure the form is submitted to the destination defined
    // in the "action" attribute of the form when valid
    submitHandler: function(form) {
      form.submit();
    }
  });
});