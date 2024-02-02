const jwt = require('jsonwebtoken');
const authRouter = require('../routes/auth');

const auth = async(req , res , next) => {
    try {
        const token = req.header("x-auth-token");
        if(!token){
            return res.status(401).json({msg: "no auth token , access denied"});
        }
        const Verified = jwt.verify(token , "passwordKey");
        if(!Verified) return res.status(401).json({msg :"token verification failed"});
        //creating a new to req i.e use and token .. now we can use these data
        req.user= Verified.id;
        req.token = token;
        next();


        
    } catch (err) {
        res.status(500).json({error: err.message});
        
    }
}
module.exports = auth;