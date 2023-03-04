/**
 * This is the express server written to handle push notification
 * and Stripe payments integration
 *
 * This is moved from Firebase Cloud function to here
 */

const express = require("express");
const admin = require("firebase-admin");
const axios = require("axios");
const { v4 } = require("uuid");

//dot env config
require("dotenv").config();

// Initializing Express
const app = express();

// JSON parsing missdleware
app.use(express.json());

//Getting admin sdk credentials
var serviceAccount = require("./serviceAccountKey.json");

// Initializing Firebase admin
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

// Creating messaging instance
const messaging = admin.messaging();

// Initializing stripe

/**
 * Route to trigger push notification
 *
 * End Point : /api/v1/notify
 *
 * [@body] : {
 * targetDevices:[<device_token>],
 * title: <Notification Title>,
 * body: <Notification Body>
 * }
 *
 */
app.post("/api/v1/notify", async (req, res) => {
  var data = req.body;

  try {
    await messaging.sendToDevice(data.targetDevices, {
      notification: {
        title: data.messageTitle,
        body: data.messageBody,
      },
    });

    return res.status(200).json({
      status: "success",
      message: "Notification Triggered Notification",
    });
  } catch (ex) {
    console.log(ex);
    return res.status(400).json({ status: "error", error: ex });
  }
});

/**
 * Route to create the order for cashfree payment
 */

app.post("/api/v1/createOrder", async (req, res) => {
  const orderId = v4();
  var amount = req.body.amount;
  var customer_id = req.body.customer_id;
  var customer_name = req.body.customer_name;
  var customer_phone = req.body.customer_phone;
  var order_note = req.body.order_note;

  var customer_email = "care@estraightwayapp.com";

  let client_id;
  let client_secret;
  let gateway_baseurl;

  if (process.env.NODE_ENV == "DEVELOPMENT") {
    client_id = process.env.CLIENT_ID_DEV;
    client_secret = process.env.CLIENT_SECRET_DEV;
    gateway_baseurl = process.env.PAYMENT_GATEWAY_DEV_BASE_URL;
  } else {
    client_id = process.env.CLIENT_ID;
    client_secret = process.env.CLIENT_SECRET;
    gateway_baseurl = process.env.PAYMENT_GATEWAY_PROD_BASE_URL
  }

  try {
    var cashfree_response = await axios({
      method: "post",
      baseURL: gateway_baseurl,
      url: "/orders",
      data: {
        order_id: orderId,
        order_amount: parseFloat(amount),
        order_currency: "INR",
        order_note: order_note,
        customer_details: {
          customer_id: customer_id,
          customer_name: customer_name,
          customer_email: customer_email,
          customer_phone: customer_phone,
        },
      },
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "x-api-version": "2022-09-01",
        "x-client-id": client_id,
        "x-client-secret": client_secret,
      },
    });

    if (cashfree_response.status === 200) {
      console.info("Order created " + cashfree_response);
      return res
        .status(200)
        .json({ status: "success", data: cashfree_response.data });
    } else {
      console.error("Error Occured1" + cashfree_response);
      return res
        .status(400)
        .json({ status: "error", message: "Unable to create order" });
    }
  } catch (error) {
    console.log(error);
    console.error("Error Occured" + error);
    return res
      .status(400)
      .json({ status: "error", message: "Unable to create order" });
  }
});

const port = process.env.PORT || 3000;

app.listen(port, () => {
  console.log(`App is listening at port ${port}...`);
});
