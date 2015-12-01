// Wait for device API libraries to load
document.addEventListener("deviceready", onDeviceReady, false);

// device APIs are available

function onDeviceReady() {
    /*var options = new ContactFindOptions();
    options.multiple = true
    var fields = ["displayName", "name"];
    navigator.contacts.find(fields, onReadySuccess, onError, options);*/
}

function findContacts() {
    var options = new ContactFindOptions();
    options.filter = "Will";
    options.multiple = true
    var fields = ["displayName", "name"]
    navigator.contacts.find(fields, onSuccess, onError, options)
}

// onSuccess: Get a snapshot of the current contacts

function onSuccess(contacts) {
    //navigator.notification.alert(JSON.stringify(contacts))
    for (var i = 0; i < contacts.length; i++) {
        navigator.notification.alert("First Name = " + contacts[i].name.givenName)
    }
}

function onReadySuccess(contacts) {
    navigator.notification.alert("Called on deviceReady, found contacts: " + contacts.length)
}

// onError: Failed to get the contacts

function onError(contactError) {
    alert('onError!');
}