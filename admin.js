const connection = require('../../conn.js');

function getDonorByEmail(req , res) {

        const email = req.body;
        connection.query("SELECT contact, bloodgroup, gender, location FROM donors WHERE email = ?" , [email] , (err, rows) => {
         
            if (err) {
                res.send(JSON.stringify(err));
            } else {
                if(rows.length > 0){
                    res.send(rows);
                }else{
                    res.send("No such user exists");
                }
               
            }
            
        });
       
    
}

function getDonors(req , res) {
          
        connection.query("SELECT contact, bloodgroup, gender, location FROM donors", (err, rows) => {
            
          if (err) {
            console.log(err);
          } else {
            res.send(rows);
          }
        })
      
}

function viewRequests(req , res) {
          
  connection.query("SELECT * FROM requests", (err, rows) => {
      
    if (err) {
      console.log(err);
    } else {
      res.send(rows);
    }
  })

}

function deleteDonor(req, res) {
  const { id } = req.body;
  existance = "SELECT * from donors where id = ?";
  declineProfile = "DELETE from donors where id = ?";
  connection.query(existance, [id], (err, rows) => {
      if (err) {
          res.send("no such id found");
      }else{
          connection.query(declineProfile , [id] , (err , rows)=>{
            if(err){
           res.send("error while declinning")
            }else{
              res.send("Profile declined")
            }
          })
      }
  });

}

function viewComplaints(req, res){
  connection.query("SELECT * FROM complaints ORDER BY id DESC", (err, rows) => {
      
    if (err) {
      res.send("server error while fetching complaints");
    } else {
      res.send(rows);
    }
  })
}

function getBloodBanks(req, res){
  connection.query("SELECT * FROM bloodbanks", (err, rows) => {
      
    if (err) {
      console.log(err);
    } else {
      res.send(rows);
    }
  })
}

function addBanks(req, res){
  const {name, city, distance_from_district, contact} = req.body;
  sql_statement = "INSERT into bloodbanks (name , city , distance, contact) values(?,? , ?, ?)"
  connection.query(complaintQuerry , [name, city, distance_from_district, contact] , (err , rows)=>{
    if(err){
        res.send("Error while adding bloodbank");
    }else{
        res.send("bloodbank added successfully");
    }
  })
}

function adminLogin(req, res) {
  let { username, password } = req.body;

  check_existance = "SELECT * from admin where username = ?";
  connection.query(check_existance, [username], (err, rows) => {
      if (err) {
          res.send("error in checking existance");
      } else {
          if (rows.length > 0) {
              check_password = "SELECT password from admin where username = ?";
              connection.query(check_password, [username], (err, rows) => {
                  if (err) { res.send("error while checking existance") } else {
                      if (rows.length > 0) {

                          if(rows[0]['password'] == password){
                            res.send("logged in")
                          }else{
                            res.send("login failed due to wrong creds")
                          }

                      } else {
                          res.send("No such admin exists");
                      }
                  }
              });
          } else {
              res.send("No such user exists");
          }
      }
  });
}

module.exports = {getDonorByEmail , getDonors , viewRequests , deleteDonor , viewComplaints , getBloodBanks , addBanks, adminLogin};