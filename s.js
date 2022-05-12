const fs = require("fs");
const csvParser = require("csv-parser");

list = [];
rows = [];

fs.createReadStream("epa_air_quality_annual_summary.csv")
  .pipe(csvParser())
  .on("data", (data) => {
    rows.push(data);
    if (rows.length === 1000) {
      console.log("pushed to list");
      list.push(rows); // <-- stream should wait for func
      rows = [];
    }
  })
  .on("end", () => {
    if (rows.length) {
      list.push(rows);
    }
    console.log(list.length);
  });
