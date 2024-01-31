const express = require("express");
const User = require("../models/user.model");
const bcryptjs = require("bcryptjs")

const authRouter = express.Router();

authRouter.post("/api/signup" , async(req , res) =>{
    // get the data from client
    //post that data in database
    // return that data
    try {
        const {name , email , password } =  req.body;
        const existingUser = await User.findOne({email});
        if(email.includes('@') == false)
        {
           return res.status(400).json({msg: "plz enter a valid email"});
        };
        if(existingUser){
            return res.status(400).json({msg : "user with same email already exist"}); // return to stop there only
        }
        //now before saving password we mush hash it using bcrypt 
        const hashedPassword = await bcryptjs.hash(password , 8);
        let user = new User({
            email,
            password : hashedPassword,
            name,
        });
        user = await user.save();  // save to db
        if(!user){
            res.status(500).json({msg : "there was a error in creating user in database"});
        }
        else{
            console.log("user successfully added in database");
        }
        res.json(user);
    } catch (error) {
        res.status(500).json({msg : "something got error " , error : e.message});
    }

})
module.exports = authRouter;