import express from "express";
const app: express.Express = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.listen(3000, () => {
  console.log("Start on port 3000.");
});

app.get("/incomes", (req: express.Request, res: express.Response) => {
  res.send(JSON.stringify({ hoge: "get incomes" }));
});

app.post("/incomes", (req: express.Request, res: express.Response) => {
  res.send(JSON.stringify({ hoge: "post incomes" }));
});

app.put("/incomes", (req: express.Request, res: express.Response) => {
  res.send(JSON.stringify({ hoge: "put incomes" }));
});

app.delete("/incomes", (req: express.Request, res: express.Response) => {
  res.send(JSON.stringify({ hoge: "delete incomes" }));
});

app.get("/expenses", (req: express.Request, res: express.Response) => {
  res.send(JSON.stringify({ hoge: "get expenses" }));
});

app.post("/expenses", (req: express.Request, res: express.Response) => {
  res.send(JSON.stringify({ hoge: "post expenses" }));
});

app.put("/expenses", (req: express.Request, res: express.Response) => {
  res.send(JSON.stringify({ hoge: "put expenses" }));
});

app.delete("/expenses", (req: express.Request, res: express.Response) => {
  res.send(JSON.stringify({ hoge: "delete expenses" }));
});
