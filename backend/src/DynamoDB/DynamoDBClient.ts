import { DynamoDBClient } from "@aws-sdk/client-dynamodb";

const dbClient = new DynamoDBClient({
  endpoint: "http://localhost:8000",
});

module.exports = { dbClient };
