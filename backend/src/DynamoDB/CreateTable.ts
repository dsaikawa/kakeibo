const {
  ListTablesCommand,
  DynamoDBClient,
} = require("@aws-sdk/client-dynamodb");
// const dynamodb = new DynamoDBClient({
//   endpoint: "http://localhost:8000",
// });
const { dbClient } = require("./DynamoDBClient.ts");

const run = async () => {
  try {
    const data = await dbClient.send(new ListTablesCommand({}));
    console.log(data);
    // console.log(data.TableNames.join("\n"));
    return data;
  } catch (err) {
    console.error(err);
  }
};
run();
