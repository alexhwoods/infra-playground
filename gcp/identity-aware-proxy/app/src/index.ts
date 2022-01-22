import * as express from "express";
import pino from "pino-http";

const app = express.default();

app.use(pino());
app.use(verify);

app.get("/", function (req, res) {
  req.log.info("something");
  res.json({
    data: "hello world",
  });
});

app.listen(3003);

function verify(
  request: express.Request,
  response: express.Response,
  next: express.NextFunction
) {
  const authorized = false;

  if (authorized) {
    next();
  } else {
    request.log.info("Here I can log some info about why they're unauthorized");
    response.status(403).json({
      error: "User not authorized",
    });
  }
}
