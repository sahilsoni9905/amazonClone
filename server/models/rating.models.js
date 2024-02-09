const mongoose = require('mongoose');

const ratingSchema = mongoose.Schema({
    userId : {
        type : String,
        required : true,
    },
    rating : {
        type : Number,
        required : true,
    }
});
// we just want to make structure we dont want to make a other model

module.exports = ratingSchema;