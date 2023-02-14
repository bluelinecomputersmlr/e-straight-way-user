const functions = require("firebase-functions");
const { v4 } = require("uuid");
const axios = require("axios");

exports.cashfreeOrderCreation = functions.https.onRequest(
  async (request, response) => {
    functions.logger.info("Cashfree Order Creation Started", {
      structuredData: true,
    });

    const orderId = v4();
    var amount = request.body.amount;
    var customer_id = request.body.customer_id;
    var customer_name = request.body.customer_name;
    var customer_phone = request.body.customer_phone;
    var order_note = request.body.order_note;

    var customer_email = "care@estraightwayapp.com";

    functions.logger.info(
      `Amount : ${amount}, Order Id : ${orderId}, Customer ID : ${customer_id}, Customer Name : ${customer_name}, Customer Phone: ${customer_phone}, Order Note: ${order_note}, DateTime : ${Date.now().toLocaleString()}`,
      { structuredData: true }
    );

    try {
      var cashfree_response = await axios({
        method: "post",
        baseURL: "https://sandbox.cashfree.com/pg/",
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
          "x-client-id": "31304119a5c5091fa9e3a93d04140313",
          "x-client-secret": "b509de64ceebbfa57cb9ae6bafcc5718b482fff3",
        },
      });

      if (cashfree_response.status === 200) {
        functions.logger.info(`Order Created Successfully!`, {
          structuredData: true,
        });

        functions.logger.info(cashfree_response, { structuredData: true });

        response
          .status(200)
          .json({ status: "success", data: cashfree_response.data });
      } else {
        functions.logger.error(`Failed to create order`, {
          structuredData: true,
        });

        functions.logger.info(cashfree_response, { structuredData: true });
        response
          .status(400)
          .json({ status: "error", message: "Unable to create order" });
      }
    } catch (error) {
      functions.logger.error(error, { structuredData: true });
    }
  }
);
