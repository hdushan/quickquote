$(document).ready ->
  $("#quoteform").bootstrapValidator fields:
    email:
      message: "Invalid email"
      validators:
        
        remote:
          message: "The email is not valid"
          url: "/checkemail"

  return