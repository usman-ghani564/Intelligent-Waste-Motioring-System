const { expect } = require("chai");
const chai = require("chai");
var supertest = require("supertest");
const chai_promise = require("chai-as-promised");
let chaiHttp = require("chai-http");
var server = supertest.agent("http://localhost:1337");
let should = require("should");

chai.use(chai_promise);

describe("Get Confidence - API Test", function () {
  describe("Return the confidence after the run of YOLO if picture has garbage - locally taken picture", function () {
    it("It should return 1 after making env ready to receive image", async function () {
      return new Promise(function (resolve) {
        server
          .get("/api/yolov5/delFiles")
          .expect("Content-type", /json/)
          .end(function (err, res) {
            // HTTP status should be 200
            res.status.should.equal(200);
            // Error key should be false.
            resolve();
          });
      });
    });
    it("It should return success after downloading image", async function () {
      return new Promise(function (resolve) {
        const url = "https://i.ibb.co/dc99Hqx/img1.jpg";
        server
          .post("/api/getimg")
          .send({ url: url })
          .expect("Content-type", /json/)
          .end(function (err, res) {
            // HTTP status should be 200
            res.status.should.equal(200);
            // Error key should be false.
            resolve();
          });
      });
    }).timeout(100000);
    it("It should return success after renaming image", async function () {
      return new Promise(function (resolve) {
        server
          .get("/api/yolov5/rename_img")
          .expect("Content-type", /json/)
          .end(function (err, res) {
            // HTTP status should be 200
            res.status.should.equal(200);
            // Error key should be false.
            resolve();
          });
      });
    });
    it("It should return success after detecting image", async function () {
      return new Promise(function (resolve) {
        server
          .get("/api/yolov5")
          .expect("Content-type", /json/)
          .end(function (err, res) {
            // HTTP status should be 200
            res.status.should.equal(200);
            // Error key should be false.
            resolve();
          });
      });
    }).timeout(900000);
    it("It should return success and 1 if confidence threshold is met", async function () {
      return new Promise(function (resolve) {
        server
          .get("/api/yolov5/confidence")
          .expect("Content-type", /json/)
          .end(function (err, res) {
            // HTTP status should be 200
            res.status.should.equal(200);
            res.body.data.should.equal("1");
            // Error key should be false.
            resolve();
          });
      });
    });
  });

  describe("Return the confidence after the run of YOLO if picture does not have garbage - internet taken picture", function () {
    it("It should return 1 after making env ready to receive image", async function () {
      return new Promise(function (resolve) {
        server
          .get("/api/yolov5/delFiles")
          .expect("Content-type", /json/)
          .end(function (err, res) {
            // HTTP status should be 200
            res.status.should.equal(200);
            // Error key should be false.
            resolve();
          });
      });
    });

    it("It should return success after downloading image", async function () {
      return new Promise(function (resolve) {
        const url = "https://i.ibb.co/1b6HzKM/house.jpg";
        server
          .post("/api/getimg")
          .send({ url: url })
          .expect("Content-type", /json/)
          .end(function (err, res) {
            // HTTP status should be 200
            res.status.should.equal(200);
            // Error key should be false.
            resolve();
          });
      });
    }).timeout(100000);

    it("It should return success after renaming image", async function () {
      return new Promise(function (resolve) {
        server
          .get("/api/yolov5/rename_img")
          .expect("Content-type", /json/)
          .end(function (err, res) {
            // HTTP status should be 200
            res.status.should.equal(200);
            // Error key should be false.
            resolve();
          });
      });
    });

    it("It should return success after detecting image", async function () {
      return new Promise(function (resolve) {
        server
          .get("/api/yolov5")
          .expect("Content-type", /json/)
          .end(function (err, res) {
            // HTTP status should be 200
            res.status.should.equal(200);
            // Error key should be false.
            resolve();
          });
      });
    }).timeout(900000);

    it("It should return success and 0 if confidence threshold is not met", async function () {
      return new Promise(function (resolve) {
        server
          .get("/api/yolov5/confidence")
          .expect("Content-type", /json/)
          .end(function (err, res) {
            // HTTP status should be 200
            res.status.should.equal(200);
            res.body.data.should.equal("0");
            // Error key should be false.
            resolve();
          });
      });
    });
  });

  describe("Return the confidence after the run of YOLO if picture have garbage - internet taken picture", function () {
    it("It should return 1 after making env ready to receive image", async function () {
      return new Promise(function (resolve) {
        server
          .get("/api/yolov5/delFiles")
          .expect("Content-type", /json/)
          .end(function (err, res) {
            // HTTP status should be 200
            res.status.should.equal(200);
            // Error key should be false.
            resolve();
          });
      });
    });

    it("It should return success after downloading image", async function () {
      return new Promise(function (resolve) {
        const url = "https://i.ibb.co/fYmQ3g2/Talking-Trash-1280x720.jpg";
        server
          .post("/api/getimg")
          .send({ url: url })
          .expect("Content-type", /json/)
          .end(function (err, res) {
            // HTTP status should be 200
            res.status.should.equal(200);
            // Error key should be false.
            resolve();
          });
      });
    }).timeout(100000);

    it("It should return success after renaming image", async function () {
      return new Promise(function (resolve) {
        server
          .get("/api/yolov5/rename_img")
          .expect("Content-type", /json/)
          .end(function (err, res) {
            // HTTP status should be 200
            res.status.should.equal(200);
            // Error key should be false.
            resolve();
          });
      });
    });

    it("It should return success after detecting image", async function () {
      return new Promise(function (resolve) {
        server
          .get("/api/yolov5")
          .expect("Content-type", /json/)
          .end(function (err, res) {
            // HTTP status should be 200
            res.status.should.equal(200);
            // Error key should be false.
            resolve();
          });
      });
    }).timeout(900000);

    it("It should return success and 1 if confidence threshold is met", async function () {
      return new Promise(function (resolve) {
        server
          .get("/api/yolov5/confidence")
          .expect("Content-type", /json/)
          .end(function (err, res) {
            // HTTP status should be 200
            res.status.should.equal(200);
            res.body.data.should.equal("1");
            // Error key should be false.
            resolve();
          });
      });
    });
  });
});
