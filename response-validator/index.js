const polka = require("polka");
const bodyParser = require("body-parser");

polka()
  .use(bodyParser.json())
  .post("/send-email-to-manager", (req, res) => {
    res.end("OK");
  })
  .listen(3000, err => {
    if (err) throw err;
    console.log(`> Running on localhost:3000`);
  });

process.on("SIGTERM", () => {
  process.exit();
});
