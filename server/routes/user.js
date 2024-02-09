const express = require('express')
const userRouter = express.Router();
const auth = require('../middleware/auth.middleware');
const { Product } = require('../models/product.models');

userRouter.post('/api/add-to-cart' , auth , async(req , res) => {
    console.log("reached to server");
    try {
       const {id} = req.body;
       const product = await Product.findById(id);
       let user = await Product.findById(req.user);

       if(user.cart.length == 0){
        user.cart.push({product , quantity : 1});
       }
       else{
        let isProductFound = false;
        for(let i = 0 ; i< user.cart.length ; i++){
            // to compare 2 object id we cant use directly ==
            if(user.cart[i].product._id.equals(product._id)){
                isProductFound = true;
            }
        }

        if(isProductFound){
            let producttt = user.cart.find((productt) => productt.product._id.equals(product._id));
            producttt.quantity +=1;
        }
        else{
            user.cart.push({product , quantity : 1})
        }
       }
       user = await user.save();
       res.json(user);
        
    } catch (e) {
        
        res.status(500).json({error : e.message});
        
    }
});




module.exports = userRouter;