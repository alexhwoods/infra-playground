import * as pulumi from "@pulumi/pulumi";
import * as postgresql from "@pulumi/postgresql";

// psql --no-password --dbname=makeswift_test --host=localhost -p 5432 --user=alexwoods
const provider = new postgresql.Provider("local", {
  host: "localhost",
  username: "alexwoods",
  sslmode: "disable",
  database: "foo",
});


const footballDb = new postgresql.Database("football", {}, { provider });
