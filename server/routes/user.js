const express = require("express");
const userRouter = express.Router();
const auth = require("../middleware/auth.middleware");
const { Product } = require("../models/product.models");
const User = require("../models/user.model");

userRouter.post("/api/add-to-cart", auth, async (req, res) => {
  console.log("reached to server");
  try {
    const { id } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);
    console.log("sahil soni part 1");

    if (user.cart.length == 0) {
        console.log("sahil soni part2");
      user.cart.push({ product, quantity: 1 });
    } else {
        console.log("sahil soni part3");
      let isProductFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        // to compare 2 object id we cant use directly ==
        if (user.cart[i].product._id.equals(product._id)) {
          isProductFound = true;
        }
      }

      if (isProductFound) {
        var producttt;
        for (var productt in user.cart) {
          if (productt.product._id == product._id) {
            producttt = productt;
            break; // stop the loop once the product is found
          }
        }
        producttt.quantity += 1;
      } else {
        user.cart.push({ product, quantity: 1 });
      }
      console.log("added to cart done from backend ");
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;
