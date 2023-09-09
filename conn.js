const mysql = require('mysql2')
let sqlConnection = mysql.createConnection({
    host:"boe3nlf3kd4ge7xgw7xe-mysql.services.clever-cloud.com" , 
    user:"u2u2uiuf2xfso5dq" , 
    password:"dVH9Sw8vWephtcP8DGiY" , 
    database:"boe3nlf3kd4ge7xgw7xe",
})

sqlConnection.connect((err)=>{
    if(err){
console.log(JSON.stringify(err));
    }else{
console.log("Database connected");
    }
})
module.exports = sqlConnection;