const s = "13-04-2022";

const months = [
  "Jan",
  "Feb",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
];

let month;
let n1;

if (s[3] == 1) {
  month = s[3] + s[4];
  n1 = months[month - 1];
} else {
  month = s[4] % 10;
  n1 = months[month - 1];
}

let newdate = s[0] + s[1] + "-" + n1 + "-" + s[6] + s[7] + s[8] + s[9];

console.log(newdate);
console.log(new Date(s));
