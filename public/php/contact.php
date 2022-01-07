<?php

$TO = 'robert@decentlabs.com';

//message the subject of the email
$SUBJECT = 'Contact from your FlexyCard';
$MSG_SEND_ERROR = 'Sorry, we can\'t send this message.';

// Sender Info
$name = $_POST['name'];
$email = $_POST['email'];
$message = $_POST['message'];
$error = "";


// Email regex
$pattern = "^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$^";

// test for name
if (empty($name)) {
    $error .= 'error-name,'; // No name 	
}

// test for email
if (empty($email) || !preg_match_all($pattern, $email)) {
    $error .= 'error-email,'; // No Email	
}

// test for message
if (empty($message)) {
    $error .= 'error-message'; // No Message	
}


//define the headers we want passed. Note that they are separated with \r\n
$headers = "From: " . $name . " <" . $email . ">\r\nReply-To: " . $email . "";

if (!$error) {

    //send the email
    $send = mail($TO, $SUBJECT, $message, $headers);

    if ($send) {
        // If the message is send successfully return success
        echo "success";
    } else {
        // If the message is not send return error
        echo $MSG_SEND_ERROR;
    }
} else {
    echo $error; // If the message is not send return error
}
?>