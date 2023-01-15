const admin = require("firebase-admin");
const functions = require("firebase-functions");

admin.initializeApp();

const messaging = admin.messaging();

exports.notifySubscribers = functions.https.onCall(async (data, _) => {
    try {
        await messaging.sendToDevice(data.targetDevices, {
            notification: {
                title: data.messageTitle,
                body: data.messageBody
            }
        });

        return JSON.stringify({ "status": true });
    } catch (ex) {
        console.log(ex);
        return JSON.stringify({ "status": false });
    }
});