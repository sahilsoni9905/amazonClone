const express = require("express");
const User = require("../models/user.model");
const bcryptjs = require("bcryptjs")
const jwt = require('jsonwebtoken');
const auth = require("../middleware/auth.middleware");

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

//sign in route 
// exercise
authRouter.post("/api/signin" , async(req , res) => {
    try {
        const {email , password} = req.body;
        
        const user = await User.findOne({email});
        if(!user){
            return res.status(400).json({msg : "user with this email not exist"});
        }
        const isMatch = await bcryptjs.compare(password , user.password);
        if(!isMatch){
            return res.status(400).json({msg : "Incorrect Password"});
        }
        const token = jwt.sign({id : user._id} , "passwordKey");
        res.json({token , ...user._doc});
        // we are sending both token and all user data in json form
        
    } catch (e) {
        res.status(500).json({error : e.message});
        
    }
})

authRouter.post("/tokenIsValid" , async(req , res) => {
    try {
        console.log("reached here");
        const token = req.header('x-auth-token');
        if(!token) return res.json(false);
        const Verified = jwt.verify(token , 'passwordKey')
        if(!Verified){
            return res.json(false);
        }
        console.log("ho gya verify");

        const user = await User.findById(Verified.id);
        if(!user) return res.json(false);
        res.json(true);
        
    } catch (e) {
        res.status(500).json({error : e.message});
        
    }
})
authRouter.get('/' , auth , async(req ,res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc , token : req.token});
})
module.exports = authRouter;