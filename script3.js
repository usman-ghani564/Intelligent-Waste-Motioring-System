import http from "k6/http";
import { sleep } from "k6";

export const options = {
  discardResponseBodies: true,
  scenarios: {
    contacts: {
      executor: "externally-controlled",
      vus: 10,
      maxVUs: 50,
      duration: "4m",
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

  sleep(1);

  console.log("Renaming Files for training");
  http.get("http://localhost:1337/api/yolov5/rename_img");

  sleep(0.5);
}
