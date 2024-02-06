const jwt = require('jsonwebtoken');
const User = require('../models/user.model');
const admin = async(req , res , next) =>{
    try {
        const token = req.header("x-auth-token");
        if(!token){
            return res.status(401).json({msg: "no auth token , access denied"});
        }
        const Verified = jwt.verify(token , "passwordKey");
        if(!Verified) return res.status(401).json({msg :"token verification failed"});
        
        const user = await User.findById(Verified.id);
        if(user.type == 'user' || user.type == 'seller'){
            return res.status(401).json({msg : "you are not an admin"});
        };
        req.user= Verified.id;
        req.token = token;
        next();


        
    } catch (err) {
        res.status(500).json({error: err.message});
        
    }
};
module.exports = admin;