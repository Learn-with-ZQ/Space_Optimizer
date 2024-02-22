function showSuccessAlert() {
    var successAlert = document.getElementById('ContentPlaceHolder1_successAlert');
    successAlert.style.display = 'flex';
    setTimeout(function () {
        dismissAlert('ContentPlaceHolder1_successAlert', successAlert.querySelector('.okBtn'));
    }, 3000);
}

function showErrorAlert() {
    var errorAlert = document.getElementById('ContentPlaceHolder1_errorAlert');
    errorAlert.style.display = 'flex';
    setTimeout(function () {
        dismissAlert('ContentPlaceHolder1_errorAlert', errorAlert.querySelector('.okBtn'));
    }, 3000);
}

function dismissAlert(alertId, button) {
    var alertElement = document.getElementById(alertId);
    alertElement.style.display = 'none';
    button.disabled = true;
}
