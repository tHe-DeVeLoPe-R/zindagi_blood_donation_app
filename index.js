const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const functions = require('firebase-functions');
const admin = require('./routes/adminRoutes/admin.js');
const user = require('./routes/userRoutes/user.js');

const app = express();
const corsOptions = {
  origin: '*',
  credentials: true,
  optionSuccessStatus: 200
}
app.use(cors(corsOptions))
app.use(bodyParser.json());
app.use(express.urlencoded({ extended: true }));

app.get("/donors", admin.getDonors);
app.post("/donor-email", admin.getDonorByEmail),
app.post("/add-bank", admin.addBanks),
app.post("/admin-login", admin.adminLogin),
app.get("/complaints", admin.viewComplaints),
app.get("/blood-banks", admin.getBloodBanks),
app.get("/requests", admin.viewRequests),
app.post("/delete-profile", admin.deleteDonor),
app.post("/add-donation", user.addDonations);
app.post("/signup", user.signup);
app.post("/login", user.login);
app.post("/updatePassword", user.updatePassword);
app.post("/updateEmail", user.updateEmail);
app.post("/updatePhone", user.updatePhone);
app.post("/search-donors", user.findDonor);
app.post("/add-complaint", user.addComplaint);
app.post("/post-request", user.donationRequest);
const PORT =  3000;
app.listen(PORT, (req, res) => {
  console.log("App is running on port ",PORT);
})

exports.zindagi = functions.https.onRequest(app);
//Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass