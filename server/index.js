const express = require("express");
const mongoose = require("mongoose");

//import from other files
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/products");
const userRouter = require("./routes/user");

const PORT = 3000;
const DB_URL = 'mongodb+srv://sonisahil9905:sahilstyles1@cluster0.vdwbstt.mongodb.net/?retryWrites=true&w=majority';



const app = express();
//middle ware
app.use(express.json())
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

// DB connection
mongoose
  .connect(DB_URL)
  .then(() => {
    console.log("connection with database is successfull");
  })
  .catch((e) => {
    console.log("error in connecting with database");
  });



app.listen(PORT, "0.0.0.0" , function () {
  console.log(`connected at port ${PORT}`);
});
