import http from "k6/http";
import { sleep } from "k6";
import { getCurrentStageIndex } from "https://jslib.k6.io/k6-utils/1.3.0/index.js";

export const options = {
  discardResponseBodies: true,
  scenarios: {
    contacts: {
      executor: "ramping-vus",
      startVUs: 0,
      stages: [
        { target: 3, duration: "10s" },
        { target: 4, duration: "30s" },
        { target: 3, duration: "10s" },
      ],
      gracefulRampDown: "0s",
    },
  },
};

export default function () {
  const url = "https://i.ibb.co/1b6HzKM/house.jpg";

  console.log("Deleting Files - making env ready testing");
  var api = "http://localhost:1337/api/yolov5/delFiles";

  http.get(api);

  sleep(0.5);

  console.log("Get Image Testing - Downloading Image for waste detection");
  api = "http://localhost:1337/api/getimg";

  http.post(api, url);
  if (getCurrentStageIndex() === 1) {
    console.log("Running the second stage where the expected target is 7");
  }

  sleep(2);

  console.log("Renaming Files for training");
  http.get("http://localhost:1337/api/yolov5/rename_img");

  sleep(0.5);
}
