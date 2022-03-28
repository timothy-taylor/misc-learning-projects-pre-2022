const email = document.getElementById("email");
email.addEventListener("input", (e) => {
    if (email.validity.typeMismatch) {
        email.setCustomValidity("I am expecting an email address!");
    } else {
        email.setCustomValidity("");
    }
});

const pwError = document.querySelector('#password + span.error');
const pw = document.getElementById("password");
pw.addEventListener("blur", () => {
    if (pw.validity.valueMissing) {
        pwError.textContent = "You can't leave this blank.";
    }
    // validity.typeMismatch
    // validity.tooShort
    // https://developer.mozilla.org/en-US/docs/Web/API/ValidityState
});
// clear error after valid input
pw.addEventListener("input", () => {
    if (pw.validity.valid) {
        pwError.textContent = "";
    }
});

