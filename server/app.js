var express = require('express')
var mongoose = require('mongoose')
const User = require("../autoacceptor/models/user")
// const https = require('https')
var querystring = require('querystring');
var request = require('request');
const axios = require('axios')
var app = express()

mongoose.connect("mongodb://127.0.0.1:27017/autoacceptor", {
    useNewUrlParser: true,
    useCreateIndex: true,
    useUnifiedTopology: true
})

// app.get('/', async (req,res) => {
//     res.json("yes")
// })

// Accept all of the follow requests
app.post('/quick', async (req, res) => {
    var burstUsers = await User.find({type: "quick"})
    burstUsers.forEach(user => {
    request({
        headers: {
            'authority': 'www.instagram.com',
            'accept': '*/*',
            'x-ig-www-claim': 'hmac.AR0TQgdacC9OagLQpr3nrIeRIhPFeTHFlHDaK3mbtE4dOjFM',
            'x-requested-with': 'XMLHttpRequest',
            'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36',
            'x-ig-app-id': '936619743392459',
            'sec-fetch-site': 'same-origin',
            'sec-fetch-mode': 'cors',
            'sec-fetch-dest': 'empty',
            'accept-language': 'en-US,en;q=0.9',
            "cookie":"sessionid="+ user.sessionID + ";" 
        },
        uri: 'https://www.instagram.com/accounts/activity/?__a=1;%00%00',
        // body: formData,
        method: 'GET'
    }, 
    (err, response, body) => {
        try{
        if(err != undefined) {
            return console.log({"error": error})
        }else{
            var usersToAccept = JSON.parse(response.body).graphql.user.edge_follow_requests.edges
            for (let i = 0; i < 4; i++) {
                if(usersToAccept[i] != undefined){
                    request({
                        headers: {
                            'User-Agent': 'Instagram 44.0.0.17.95 (iPhone9,3; iOS 12_0; en_US; en-US; scale=2.00; gamut=wide; 750x1334) AppleWebKit/420+',
                            "cookie":"sessionid=" + user.sessionID + ";" 
                        },
                        uri: 'https://i.instagram.com/api/v1/friendships/approve/' + usersToAccept[i].node.id + '/',
                        // body: formData,
                        method: 'POST'
                    }, (err, response, body) => {
                        if (err != undefined) {
                            return console.log({"error": error})
                        }
                    })}else{
                        return console.log("Accepted " + i + " users for " + user.sessionID)
                    }
            }
        }
    }catch{}
    res.json("yes")
    })
});
})

app.post('/burst', async (req, res) => {
    var burstUsers = await User.find({type: "burst"})
    burstUsers.forEach(user => {
    request({
        headers: {
            'authority': 'www.instagram.com',
            'accept': '*/*',
            'x-ig-www-claim': 'hmac.AR0TQgdacC9OagLQpr3nrIeRIhPFeTHFlHDaK3mbtE4dOjFM',
            'x-requested-with': 'XMLHttpRequest',
            'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36',
            'x-ig-app-id': '936619743392459',
            'sec-fetch-site': 'same-origin',
            'sec-fetch-mode': 'cors',
            'sec-fetch-dest': 'empty',
            'accept-language': 'en-US,en;q=0.9',
            "cookie":"sessionid="+ user.sessionID + ";" 
        },
        uri: 'https://www.instagram.com/accounts/activity/?__a=1;%00%00',
        // body: formData,
        method: 'GET'
    }, 
    (err, response, body) => {
        try{
        if(err != undefined) {
            return console.log({"error": error})
        }else{
            var usersToAccept = JSON.parse(response.body).graphql.user.edge_follow_requests.edges
            for (let i = 0; i < 998; i++) {
                if(usersToAccept[i] != undefined){
                    request({
                        headers: {
                            'User-Agent': 'Instagram 44.0.0.17.95 (iPhone9,3; iOS 12_0; en_US; en-US; scale=2.00; gamut=wide; 750x1334) AppleWebKit/420+',
                            "cookie":"sessionid=" + user.sessionID + ";" 
                        },
                        uri: 'https://i.instagram.com/api/v1/friendships/approve/' + usersToAccept[i].node.id + '/',
                        // body: formData,
                        method: 'POST'
                    }, (err, response, body) => {
                        if (err != undefined) {
                            return console.log({"error": error})
                        }
                    })}else{
                        return console.log("Accepted " + i + " users for " + user.sessionID)
                    }
            }
        }
    }catch{}
    res.json("yes")
    })
});
})

app.post('/safe', async (req, res) => {
    var burstUsers = await User.find({type: "safe"})
    burstUsers.forEach(user => {
    request({
        headers: {
            'authority': 'www.instagram.com',
            'accept': '*/*',
            'x-ig-www-claim': 'hmac.AR0TQgdacC9OagLQpr3nrIeRIhPFeTHFlHDaK3mbtE4dOjFM',
            'x-requested-with': 'XMLHttpRequest',
            'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36',
            'x-ig-app-id': '936619743392459',
            'sec-fetch-site': 'same-origin',
            'sec-fetch-mode': 'cors',
            'sec-fetch-dest': 'empty',
            'accept-language': 'en-US,en;q=0.9',
            "cookie":"sessionid="+ user.sessionID + ";" 
        },
        uri: 'https://www.instagram.com/accounts/activity/?__a=1;%00%00',
        // body: formData,
        method: 'GET'
    }, 
    (err, response, body) => {
        try{
        if(err != undefined) {
            return console.log({"error": error})
        }else{
            var usersToAccept = JSON.parse(response.body).graphql.user.edge_follow_requests.edges
            for (let i = 0; i < 998; i++) {
                if(usersToAccept[i] != undefined){
                    request({
                        headers: {
                            'User-Agent': 'Instagram 44.0.0.17.95 (iPhone9,3; iOS 12_0; en_US; en-US; scale=2.00; gamut=wide; 750x1334) AppleWebKit/420+',
                            "cookie":"sessionid=" + user.sessionID + ";" 
                        },
                        uri: 'https://i.instagram.com/api/v1/friendships/approve/' + usersToAccept[i].node.id + '/',
                        // body: formData,
                        method: 'POST'
                    }, (err, response, body) => {
                        if (err != undefined) {
                            return console.log({"error": error})
                        }
                    })}else{
                        return console.log("Accepted " + i + " users for " + user.sessionID)
                    }
            }
        }
    }catch{}
    res.json("yes")
    })
});
})

// Login a user, get a session and save to the database
app.post('/instalogin', async (req, res) => {
    var email = req.query.email; 
    var password = req.query.password; 
    var type = req.query.type; 
    if (email == "" || password == "" || email == undefined || password == undefined ) {
        res.end(JSON.stringify({ "error" : "Empty credentials"}))
    }else{
        var form = {
            ig_sig_key_version: '5' ,
            reg_login: "0",
            password:password,
            username: email,
            device_id: "bc8940a7-7215-4c54-a512-9ddfe7299edb",
            adid: 'FE4FD084-9DCB-481A-A248-57E0E32E25ED',
            login_attempt_count: '0',
            phone_id: 'bc8940a7-7215-4c54-a512-9ddfe7299edb'
        };
        
        var formData = querystring.stringify(form);
        // var contentLength = formData.length;
        
        try{
            

            request({
                headers: {
                //   'Content-Length': contentLength,
                "User-Agent": 'Instagram 44.0.0.17.95 (iPhone9,3; iOS 12_0; en_US; en-US; scale=2.00; gamut=wide; 750x1334) AppleWebKit/420+',
                'Content-Type': 'application/x-www-form-urlencoded'
                },
                    uri: 'https://i.instagram.com/api/v1/accounts/login/',
                    body: formData,
                    method: 'POST'
            }, async(err, response, body) => {
                    if(JSON.parse(body).error_title != undefined){
                        // return res.json(JSON.parse(body).error_title)
                        return res.json({ "error" : JSON.parse(body).error_title})
                    }
                    var sessionID = ((response.headers["set-cookie"][response.headers["set-cookie"].length-1] + " ").split("; ")[0]).split('=')[1]
                    let exisitngUser = await User.find({})
                    if(exisitngUser.length != 0){
                        return res.json({ "success" : true})
                    }
                    const user = new User({
                        email,
                        password,
                        type:type,
                        sessionID: sessionID
                    })
                    // console.log(await burstStart(sessionID) + " yup")
                    try {
                        user.save()
                        res.json({ "success" : true})
                    } catch (error) {
                        res.json({ "error" : error})
                    }
                });
            }catch{
                return res.json({ "error" : "Couldn't save the User(bad credentials)"});
            }
    }
})

app.post('/changeToBurst', async (req, res) => {
    var email = req.query.email
    let exisitngUser = await User.find({email})
    if(exisitngUser.length != 0){
        await User.updateOne({email}, {"type":"burst"})
        return res.json({"success":true})
    }
    res.json({"success":false})
})


app.post('/changeToQuick', async (req, res) => {
    var email = req.query.email
    let exisitngUser = await User.find({email})
    if(exisitngUser.length != 0){
        await User.updateOne({email}, {"type":"quick"})
        return res.json({"success":true})
    }
    res.json({"success":false})
})


app.post('/changeToSafe', async (req, res) => {
    var email = req.query.email
    let exisitngUser = await User.find({email})
    if(exisitngUser.length != 0){
        await User.updateOne({email}, {"type":"safe"})
        return res.json({"success":true})
    }
    res.json({"success":false})
})

var port = "8000"
app.listen(port, () => {
    // Quick Mode
    setInterval(() =>{
        axios.post('http://192.168.1.3:8000/quick', {})
          .then((response) => {
            // console.log(response);
          }, (error) => {
            // console.log(error);
          });
    }, 2000)


    // Burst Mode
    setInterval(() =>{
        axios.post('http://192.168.1.3:8000/burst', {})
          .then((response) => {
            console.log(response);
          }, (error) => {
            console.log(error);
          });
    },900000);

    // Safe Mode
    setInterval(() =>{
        axios.post('http://192.168.1.3:8000/safe', {})
          .then((response) => {
            console.log(response);
          }, (error) => {
            console.log(error);
          });
    },3600000);

    console.log("Server is up on port " + port)
})