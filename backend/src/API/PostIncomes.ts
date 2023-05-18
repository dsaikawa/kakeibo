import express from "express";

export const postIncomes = (req: express.Request, res: express.Response) => {
  console.log(req.body);
  res.send(JSON.stringify({ hoge: "fugafuga" }));
};
