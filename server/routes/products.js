const express = require('express');
const productRouter = express.Router();
const auth = require('../middleware/auth.middleware');


// /api/products?category=Essentials
productRouter.get('/api/products' , auth , async(req , res) => {
    try {
        console.log(req.query.category);
        const products = await Product.find({category : req.query.category}); // it give list of all the data in Product model
        res.json(products);
    } catch (e) {
        res.status(500).json({error : e.message});
    }
})

module.exports= productRouter;