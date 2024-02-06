const express = require('express');
const adminRouter = express.Router();
const admin = require('../middleware/admin.middleware');
const Product = require('../models/product.models')


// created an admin middleware 
adminRouter.post('/admin/add-product' , admin , async(req , res) => {
    console.log("reached to server");
    try {
        const {name , description , images , quantity  , price , category} = req.body;
        let product = new Product({
            name ,
            description,
            images,
            quantity,
            price,
            category,
        })
        product = await product.save();   // saving to database;
        res.json(product);
        
    } catch (e) {

        res.status(500).json({error : e.message});
        
    }
});
// get all the product
adminRouter.get('/admin/get-products' , admin , async(req , res) => {
    try {
        const products = await Product.find({}); // it give list of all the data in Product model
        res.json(products);
    } catch (e) {
        res.status(500).json({error : e.message});
    }
})
// delete the product

adminRouter.post('/admin/delete-product' , admin , async(req , res) => {
     try {
        const {id} = req.body;
        let product = await Product.findByIdAndDelete(id);
       
        res.json(product);
     } catch (error) {
        
     }
})
module.exports = adminRouter;