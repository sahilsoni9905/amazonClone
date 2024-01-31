const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    name : {
        required : true,
        type : String,
        trim: true,

    },
    email : {
        required : true,
        type : String,
        
  
    },
    password: {
        required : true,
        type : String,
        validator : (value) => {
            return value.length > 6;
        },
        message : "plz enter a long password"
    },
    address : {
        type : String,
        default : '',
    },
    type : {
        type : String,
        default : 'user',
    }
})

const User = mongoose.model("User" , userSchema);
module.exports = User;