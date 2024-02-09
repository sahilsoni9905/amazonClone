const express = require('express');
const productRouter = express.Router();
const auth = require('../middleware/auth.middleware');
const {Product} = require('../models/product.models');
const authRouter = require('./auth');


// /api/products?category=Essentials
productRouter.get('/api/products' , auth , async(req , res) => {
    try {
        console.log(req.query.category);
        const products = await Product.find({category : req.query.category}); // it give list of all the data in Product model
        res.json(products);
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});

productRouter.get('/api/products/search/:name' , auth , async(req , res) => {
    try {
       
        const products = await Product.find({
            name : {$regex : req.params.name , $options: "i"},// to make search part
        }); 
        res.json(products);
    } catch (e) {
        res.status(500).json({error : e.message});
    }
});
productRouter.post('/api/rate-product' , auth , async(req , res) => {
    try {
        // the product id is id
        const {id , rating} = req.body;
        let product = await Product.findById(id);
        // now we will check whether he has given rating already or not 
        for(let i = 0 ; i< product.rating.length ; i++){
            if(product.rating[i].userId == req.user){
                product.rating.splice(i , 1);
                break;
            }
        }

        const ratingSchema = {
            userId : req.user,
            rating : rating,
        };
        product.rating.push(ratingSchema);
        product = await product.save();
    } catch (e) {
        res.status(500).json({error : e.message});
    }
})

productRouter.get('/api/deal-of-the-day' , auth , async(req , res) => {
    try {
        console.log("sahil   1");
        let products = await Product.find({});
        console.log("sahil   2");  // this is not getting print
        // now the one who has most avg rating will become deal of the day
        products.sort((a , b) => {
            let aSum = 0;
            let bSum = 0;
            for(let i = 0 ; i< a.rating.length  ; i++){
                aSum += a.rating[i];
            }
            for(let i = 0 ; i< b.rating.length  ; i++){
                bSum += b.rating[i];
            }
            return aSum < bSum ? 1 : -1;
        });
        res.json(products[0]);
        
    } catch (e) {
        res.status(500).json({e : e.message});
    }
})


module.exports= productRouter;