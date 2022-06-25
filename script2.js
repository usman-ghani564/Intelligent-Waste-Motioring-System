import http from "k6/http";
import { sleep } from "k6";
import { getCurrentStageIndex } from "https://jslib.k6.io/k6-utils/1.3.0/index.js";
import exec from "k6/execution";

export const options = {
  discardResponseBodies: true,

  scenarios: {
    contacts: {
      executor: "ramping-arrival-rate",

      // Our test with at a rate of 300 iterations started per `timeUnit` (e.g minute).
      startRate: 100,

      // It should start `startRate` iterations per minute
      timeUnit: "30s",

      // It should preallocate 2 VUs before starting the test.
      preAllocatedVUs: 2,

      // It is allowed to spin up to 50 maximum VUs in order to sustain the defined
      // constant arrival rate.
      maxVUs: 50,

      stages: [
        // It should start 300 iterations per `timeUnit` for the first minute.
        { target: 300, duration: "40s" },

        // It should linearly ramp-up to starting 600 iterations per `timeUnit` over the following two minutes.
        { target: 600, duration: "50s" },

        // It should continue starting 600 iterations per `timeUnit` for the following four minutes.
        { target: 600, duration: "2m" },

        // It should linearly ramp-down to starting 60 iterations per `timeUnit` over the last two minute.
        { target: 60, duration: "2m" },
      ],
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
