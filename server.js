//Packages: express, body-parser
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const app = express();
var http = require("http");
var fs = require("fs");
const download = require("download");
const morgan = require("morgan");

var corsOptions = {
  origin: "http://localhost:3000",
};
app.use(cors(corsOptions));
app.use(express.json());

app.use(morgan("dev"));

const port = process.env.PORT || 1337;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept, Authorization"
  );
  if (req.method === "OPTIONS") {
    res.header("Access-Control-Allow-Methods", "PUT, POST, PATCH, DELETE, GET");
    return res.status(200).json({});
  }
  next();
});

app.get("/test/get", cors(), (req, res) => {
  res.send({ express: "YAHALLO! From Express Server" });
});

app.post("/test/post", (req, res) => {
  console.log(req.body);
  res.send(`GOT YOUR MESSAGE!! This is what you said to me: ${req.body.post}`);
});

app.post(`/api/airQ`, cors(), (req, res) => {
  const air = {
    id: airQulity.length + 1,
    name: req.body.name,
  };
  airQulity.push(air);
  res.send(air);
});

app.get("/api/yolov5", (req, res) => {
  var name = 2;
  var choice = 0;
  var spawn = require("child_process").spawn;
  var process = spawn("python", ["./read.py", choice, name]);
  process.stdout.on("data", function (data) {
    res.send(data.toString());
  });
});

app.get("/api/getimg", async (req, res) => {
  try {
    // Url of the image
    const url =
      "https://firebasestorage.googleapis.com/v0/b/fyp-project-98f0f.appspot.com/o/images%2FimageName?alt=media&token=2986a839-f2c0-4239-a46f-553a733dee77";
    // Path at which image will get downloaded
    const filePath = `${__dirname}/testimg`;

    download(url, filePath).then(() => {
      console.log("Download Completed");
      res.send({ status: "1" });
    });
  } catch (e) {
    res.send(e.message);
  }
});

app.get("/api/yolov5/delFiles", (req, res) => {
  var name = 2;
  var choice = 3;
  var spawn = require("child_process").spawn;
  var process = spawn("python", ["./read.py", choice, name]);
  process.stdout.on("data", function (data) {
    res.send(data.toString()[0]);
  });
});

app.get("/api/yolov5/rename_img", (req, res) => {
  var name = 2;
  var choice = 2;
  var spawn = require("child_process").spawn;
  var process = spawn("python", ["./read.py", choice, name]);
  process.stdout.on("data", function (data) {
    res.send(data.toString()[0]);
  });
});

app.get("/api/yolov5/confidence", (req, res) => {
  var name = 2;
  var choice = 1;
  var spawn = require("child_process").spawn;
  var process = spawn("python", ["./read.py", choice, name]);
  process.stdout.on("data", function (data) {
    res.send(data.toString()[0]);
  });
});

app.get("/api/yolov5", (req, res) => {
  try {
    var name = 2;
    var choice = 0;
    var spawn = require("child_process").spawn;
    var process = spawn("python", ["./read.py", choice, name]);
    process.stdout.on("data", function (data) {
      res.send(data.toString()[0]);
    });
  } catch (e) {
    res.status(500).json({ status: -1 });
  }
});

app.listen(port, () => console.log(`Listening on port ${port}`));
