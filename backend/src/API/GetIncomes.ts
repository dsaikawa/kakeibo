import express from "express";

export const getIncomes = (res: express.Response) => {
  res.send(JSON.stringify({ hoge: "hogehoge" }));
};
