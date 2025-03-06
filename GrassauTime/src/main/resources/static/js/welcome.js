function checkLength() {
    var inputField = document.getElementById("cardNumber");
    if (inputField.value.length >= 10) {
        document.getElementById("activityLogger").submit(); // Submit the form if 10 or more characters
    }
}