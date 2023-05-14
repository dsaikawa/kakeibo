const app = Elm.Main.init();

app.ports.liffInit.subscribe((_) => {
  liff
    .init({
      liffId: "1660879271-M9Po305v",
    })
    .then(() => {
      const IDToken = liff.getIDToken();
      app.ports.liffIDTokenReceiver.send(IDToken);
    });
});
