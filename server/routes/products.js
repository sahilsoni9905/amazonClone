const express = require('express');
const productRouter = express.Router();
const auth = require('../middleware/auth.middleware');
const Product = require('../models/product.models')


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



module.exports= productRouter;