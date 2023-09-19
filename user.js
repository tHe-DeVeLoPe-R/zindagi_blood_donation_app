
const connection = require('../../conn.js');
const bcrypt = require('bcryptjs');


function signup(req, res) {

    let { email, password, contact, bloodgroup, gender, age, location, balance } = req.body;
    // - encrypting password
    password = bcrypt.hashSync(password, 10);

    check_existance = "SELECT * from donors where email = ?";

    connection.query(check_existance, [email], (err, rows) => {

        if (err) {
            res.send(JSON.stringify(err));
        } else if (rows.length < 1) {
            add_donor = "INSERT into donors (email , password, contact , bloodgroup ,gender , age , location , balance) values (?, ?, ?, ?, ?, ?, ? , ?)";
            connection.query(add_donor, [email, password, contact, bloodgroup, gender, age, location, balance], (err, rows) => {
                if (err) {
                    res.send("Signup failed due to server error");
                } else {
                    res.send("You signed up as a donor successfully");
                }
            });
        } else {

            res.send("record already exists against this email " + email);

        }
    });

}

function login(req, res) {
    let { email, password } = req.body;

    check_existance = "SELECT * from donors where email = ?";
    connection.query(check_existance, [email], (err, rows) => {
        if (err) {
            res.send("error in checking existance");
        } else {
            if (rows.length > 0) {
                check_password = "SELECT password from donors where email = ?";
                connection.query(check_password, [email], (err, rows) => {
                    if (err) { res.send(JSON.stringify(err)) } else {
                        if (rows.length > 0) {

                            bcrypt.compare(password, rows[0]['password'], (err, allowed) => {
                                if (allowed) {
                                    res.send("logged in");
                                } else {
                                    res.send("Access denied wrong password");
                                }
                            })

                        } else {
                            res.send("No such user exists");
                        }
                    }
                });
            } else {
                res.send("No such user exists");
            }
        }
    });
}


function updatePassword(req, res) {
    let {email, new_password } = req.body;
    new_password = bcrypt.hashSync(new_password, 10);
    update_password = "UPDATE donors SET password = ? WHERE email = ?";
    connection.query(update_password, [new_password, email], (err, rows) => {
        if (err) {
            res.send("password not updated due to server error");
        } else {
            res.send("Pasword updated");
        }
    })
}

function updateEmail(req, res) {
    const {email, new_email} = req.body;
    update_email = "UPDATE donors SET email = ? WHERE email = ?";
                        connection.query(update_email, [new_email, email], (err, rows) => {
                            if (err) {
                                res.send("email not updated due to server error");
                            } else {
                                res.send("Email updated");
                            }
                        })
}

function updatePhone(req, res) {
    const {email, phone} = req.body;
    update_contact = "UPDATE donors SET contact = ? WHERE email = ?";
    connection.query(update_password, [phone, email], (err, rows) => {
        if (err) {
            res.send(JSON.stringify(err));
        } else {
            res.send("Contact updated");
        }
    })
}

function donationRequest(req, res) {
    const { name, adres, contact, bloodgroup_required, amount } = req.body;
    add_request = 'INSERT into requests (name , adres , contact , bloodgroup , amount) values(?, ?, ?, ?, ?)';

    connection.query(addDonations, [name, adres, contact, bloodgroup_required, amount], (err, rows) => {
        if (err) {
            res.send("Error posting request");
        } else {
            res.send("Request submitted successfully", rows);
        }
    });
}

function deleteRequest(req, res) {
    let { id } = req.body;
    existance = "";
    connection.query(existance, [id], (err, rows) => {
        if (err) {
            res.send(JSON.stringify(err));
        } else {
            res.send("request found", rows);
        }
    });
}

function findDonor(req, res) {
    const { bloodgroup, city } = req.body;
    searchDonor = "SELECT * from donors WHERE bloodgroup = ? and location = ?";
    
    connection.query(searchDonor, [bloodgroup, city], (err, rows) => {
        if (err) {
            res.json({response:"0 donors matches your search"});
        } else {
           res.send(rows);
           
        }
    })
}

function addComplaint(req, res) {
  const {email , complaint} = req.body;
  
  complaintQuerry = "INSERT into complaints (email , complaint , status) values(?,? , ?)";

  connection.query(complaintQuerry , [email , complaint , "1"] , (err , rows)=>{
    if(err){
        res.send("Error while adding complaint");
    }else{
        res.send("Complaint added successfully");
    }
  })
}

module.exports = { addDonations, signup, login, updatePassword, updateEmail, updatePhone, donationRequest, deleteRequest, findDonor , addComplaint };