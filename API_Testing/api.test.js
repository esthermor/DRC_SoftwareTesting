const request = require("supertest");
const { isString, isInteger } = require("@junchan/type-check");

describe("API test", () => {
  const baseurl = "https://api.coingecko.com/api/v3/coins";

  ////////////////////////////////////////////////// Positive scenarios ///////////////////////////////////////////////////////

  it("should fetch the list of coins based on currency: USD", async () => {
    let res = await request(baseurl)
      .get(
        "/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=false"
      )
      .set("accept", "application/json");
    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
    const data = res.body[0];
    expect(isString(data.id)).toBe(true);
    expect(isString(data.symbol)).toBe(true);
    expect(isString(data.name)).toBe(true);
    expect(isString(data.image)).toBe(true); //check type data of image
    expect(typeof data.current_price).toBe("number");
    // expect(isInteger(data.market_cap)).toBe(true); //check datatype fo marketcap
    expect(typeof data.price_change_24h).toBe("number");
  });

  it("should fetch the list of coins based on currency: EUR", async () => {
    let res = await request(baseurl)
      .get(
        "/markets?vs_currency=eur&order=market_cap_desc&per_page=250&page=1&sparkline=false"
      )
      .set("accept", "application/json");
    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
    const data = res.body[0];
    expect(isString(data.id)).toBe(true);
    expect(isString(data.symbol)).toBe(true);
    expect(isString(data.name)).toBe(true);
    expect(isString(data.image)).toBe(true);
    expect(typeof data.current_price).toBe("number");
    expect(typeof data.price_change_24h).toBe("number");
  });

  it("should fetch the list of coins based on currency: MYR", async () => {
    let res = await request(baseurl)
      .get(
        "/markets?vs_currency=myr&order=market_cap_desc&per_page=250&page=1&sparkline=false"
      )
      .set("accept", "application/json");
    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
    const data = res.body[0];
    expect(isString(data.id)).toBe(true);
    expect(isString(data.symbol)).toBe(true);
    expect(isString(data.name)).toBe(true);
    expect(isString(data.image)).toBe(true);
    expect(isInteger(data.current_price)).toBe(true);
    expect(typeof data.price_change_24h).toBe("number");
  });

  it("should fetch the list of coins based on currency: JPY", async () => {
    let res = await request(baseurl)
      .get(
        "/markets?vs_currency=jpy&order=market_cap_desc&per_page=250&page=1&sparkline=false"
      )
      .set("accept", "application/json");
    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
    const data = res.body[0];
    expect(isString(data.id)).toBe(true);
    expect(isString(data.symbol)).toBe(true);
    expect(isString(data.name)).toBe(true);
    expect(isString(data.image)).toBe(true);
    expect(isInteger(data.current_price)).toBe(true);
    expect(typeof data.price_change_24h).toBe("number");
  });

  it("should fetch the list of coins based on currency: GBP", async () => {
    let res = await request(baseurl)
      .get(
        "/markets?vs_currency=gbp&order=market_cap_desc&per_page=250&page=1&sparkline=false"
      )
      .set("accept", "application/json");
    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
    const data = res.body[0];
    expect(isString(data.id)).toBe(true);
    expect(isString(data.symbol)).toBe(true);
    expect(isString(data.name)).toBe(true);
    expect(isString(data.image)).toBe(true);
    expect(typeof data.current_price).toBe("number");
    expect(typeof data.price_change_24h).toBe("number");
  });

  it("should fetch the list of coins based on currency: AUD", async () => {
    let res = await request(baseurl)
      .get(
        "/markets?vs_currency=aud&order=market_cap_desc&per_page=250&page=1&sparkline=false"
      )
      .set("accept", "application/json");
    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
    const data = res.body[0];
    expect(isString(data.id)).toBe(true);
    expect(isString(data.symbol)).toBe(true);
    expect(isString(data.name)).toBe(true);
    expect(isString(data.image)).toBe(true);
    expect(isInteger(data.current_price)).toBe(true);
    expect(typeof data.price_change_24h).toBe("number");
  });

  it("should fetch the list of coins based on currency: CAD", async () => {
    let res = await request(baseurl)
      .get(
        "/markets?vs_currency=cad&order=market_cap_desc&per_page=250&page=1&sparkline=false"
      )
      .set("accept", "application/json");
    expect(res.statusCode).toBe(200);
    expect(Array.isArray(res.body)).toBe(true);
    const data = res.body[0];
    expect(isString(data.id)).toBe(true);
    expect(isString(data.symbol)).toBe(true);
    expect(isString(data.name)).toBe(true);
    expect(isString(data.image)).toBe(true);
    expect(isInteger(data.current_price)).toBe(true);
    expect(typeof data.price_change_24h).toBe("number");
  });

  it("should fetch a single coin", async () => {
    let res = await request(baseurl)
      .get("/bitcoin")
      .set("accept", "application/json");
    expect(res.statusCode).toBe(200);
    const data = res.body;
    expect(isString(data.id)).toBe(true);
    expect(isString(data.symbol)).toBe(true);
    expect(isString(data.name)).toBe(true);
    expect(isInteger(data.market_cap_rank)).toBe(true);
  });

  it("should fetch the historical chart", async () => {
    let res = await request(baseurl)
      .get("/bitcoin/market_chart?vs_currency=usd&days=365")
      .set("accept", "application/json");
    expect(res.statusCode).toBe(200);
    const data = res.body;
    expect(Array.isArray(data.prices)).toBe(true); //to recheck
  });

  it("should fetch the trending coin based on currency: USD", (done) => {
    request(baseurl)
      .get(
        "/markets?vs_currency=usd&order=gecko_desc&per_page=10&page=1&sparkline=false&price_change_percentage=24h"
      )
      .set("accept", "application/json")
      .end(function (err, res) {
        if (err) {
          throw err;
        }
        expect(res.statusCode).toBe(200);
        done();
      });
  });

  it("should fetch the trending coin based on currency: EUR", (done) => {
    request(baseurl)
      .get(
        "/markets?vs_currency=eur&order=gecko_desc&per_page=10&page=1&sparkline=false&price_change_percentage=24h"
      )
      .set("accept", "application/json")
      .end(function (err, res) {
        if (err) {
          throw err;
        }
        expect(res.statusCode).toBe(200);
        done();
      });
  });

  it("should fetch the trending coin based on currency: MYR", (done) => {
    request(baseurl)
      .get(
        "/markets?vs_currency=myr&order=gecko_desc&per_page=10&page=1&sparkline=false&price_change_percentage=24h"
      )
      .set("accept", "application/json")
      .end(function (err, res) {
        if (err) {
          throw err;
        }
        expect(res.statusCode).toBe(200);
        done();
      });
  });

  it("should fetch the trending coin based on currency: JPY", (done) => {
    request(baseurl)
      .get(
        "/markets?vs_currency=jpy&order=gecko_desc&per_page=10&page=1&sparkline=false&price_change_percentage=24h"
      )
      .set("accept", "application/json")
      .end(function (err, res) {
        if (err) {
          throw err;
        }
        expect(res.statusCode).toBe(200);
        done();
      });
  });

  it("should fetch the trending coin based on currency: GBP", (done) => {
    request(baseurl)
      .get(
        "/markets?vs_currency=gbp&order=gecko_desc&per_page=10&page=1&sparkline=false&price_change_percentage=24h"
      )
      .set("accept", "application/json")
      .end(function (err, res) {
        if (err) {
          throw err;
        }
        expect(res.statusCode).toBe(200);
        done();
      });
  });

  it("should fetch the trending coin based on currency: AUD", (done) => {
    request(baseurl)
      .get(
        "/markets?vs_currency=aud&order=gecko_desc&per_page=10&page=1&sparkline=false&price_change_percentage=24h"
      )
      .set("accept", "application/json")
      .end(function (err, res) {
        if (err) {
          throw err;
        }
        expect(res.statusCode).toBe(200);
        done();
      });
  });

  it("should fetch the trending coin based on currency: CAD", (done) => {
    request(baseurl)
      .get(
        "/markets?vs_currency=cad&order=gecko_desc&per_page=10&page=1&sparkline=false&price_change_percentage=24h"
      )
      .set("accept", "application/json")
      .end(function (err, res) {
        if (err) {
          throw err;
        }
        expect(res.statusCode).toBe(200);
        done();
      });
  });

  //////////////////////////////////////////////// Negative scenarios ////////////////////////////////////////////////////////////

  it("should not fetch the list of coins with invalid currency", (done) => {
    request(baseurl)
      .get(
        "/markets?vs_currency=testdata&order=market_cap_desc&per_page=250&page=1&sparkline=false"
      )
      .set("accept", "application/json")
      .end(function (err, res) {
        if (err) {
          throw err;
        }
        expect(res.statusCode).toBe(400);
        done();
      });
  });

  it("should not be able to fetch a single coin with invalid coin ID", (done) => {
    request(baseurl)
      .get("/testdata")
      .set("accept", "application/json")
      .end(function (err, res) {
        if (err) {
          throw err;
        }
        expect(res.statusCode).toBe(404);
      });
    done();
  });

  it("should not be able to fetch the historical chart with invalid coin ID", (done) => {
    request(baseurl)
      .get("/testdata/market_chart?vs_currency=usd&days=365")
      .set("accept", "application/json")
      .end(function (err, res) {
        if (err) {
          throw err;
        }
        expect(res.statusCode).toBe(404);
        done();
      });
  });

  it("should not be able to fetch the historical chart with invalid currency", (done) => {
    request(baseurl)
      .get("/bitcoin/market_chart?vs_currency=testdata&days=365")
      .set("accept", "application/json")
      .end(function (err, res) {
        if (err) {
          throw err;
        }
        expect(res.statusCode).toBe(400);
        done();
      });
  });

  it("should not be able to fetch the trending coins by invalid currency", (done) => {
    request(baseurl)
      .get(
        "/markets?vs_currency=testdata&order=gecko_desc&per_page=10&page=1&sparkline=false&price_change_percentage=24h"
      )
      .set("accept", "application/json")
      .end(function (err, res) {
        if (err) {
          throw err;
        }
        expect(res.statusCode).toBe(400);
        done();
      });
  });
});
