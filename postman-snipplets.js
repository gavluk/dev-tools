var jsonData;

// Status 200
pm.test("Status code is 200", function () {
    pm.response.to.have.status(200);
});

// Just check if some data (token) is here
pm.test("Token is here", function () {
    jsonData = pm.response.json();
    pm.expect(jsonData.token).to.be.not.empty;
    pm.globals.set("token", jsonData.token);    
});

// Check token is jwt and decode token data
pm.test("Token is JWT", function () {

    // TODO: decode JWT token    
    [jwtHeader, jwtToken,jwtSignature] = jsonData.token.split(".");
    
    var atob = require('atob');
    console.log(atob(jwtHeader));
    console.log(atob(jwtToken));
    
    jwtHeaderJson = JSON.parse(atob(jwtHeader))
    jwtTokenJson = JSON.parse(atob(jwtToken))
    
    pm.expect(jwtTokenJson.username).to.be.not.empty; // username present in jwt
    pm.expect(jwtTokenJson.iat).to.be.above(Date.now()/1000-100); // issued at not later then 100 sec from now (dont know about TZ)
    
});

// faker available data: https://www.npmjs.com/package/faker
// Docker to run (e.g. on https://faker.digitalharbour.io/) 
// https://hub.docker.com/r/rahmatawaludin/faker-server

var fakerServerOrigin = "https://faker.digitalharbour.io";

pm.sendRequest(fakerServerOrigin + "/?property=name.findName", function (err, response) {
    pm.globals.set("fake.name", response.text());
});

pm.sendRequest(fakerServerOrigin + "/?property=internet.userName", function (err, response) {
    pm.globals.set("fake.login", response.text());
});

pm.sendRequest(fakerServerOrigin + "/?property=finance.iban", function (err, response) {
    pm.globals.set("fake.iban", response.text());
});

pm.sendRequest(fakerServerOrigin + "/?property=finance.bic", function (err, response) {
    pm.globals.set("fake.swift", response.text());
});

pm.sendRequest(fakerServerOrigin + "/?property=finance.currencyCode", function (err, response) {
    pm.globals.set("fake.currency", response.text());
});

pm.sendRequest(fakerServerOrigin + "/?property=company.companyName", function (err, response) {
    pm.globals.set("fake.company", response.text());
});

pm.sendRequest(fakerServerOrigin + "/?property=address.streetAddress", function (err, response) {
    pm.globals.set("fake.address", response.text());
});

pm.sendRequest(fakerServerOrigin + "/?property=address.zipCode", function (err, response) {
    pm.globals.set("fake.zip", response.text());
});

pm.sendRequest(fakerServerOrigin + "/?property=address.city", function (err, response) {
    pm.globals.set("fake.city", response.text());
});

pm.sendRequest(fakerServerOrigin + "/?property=address.countryCode", function (err, response) {
    pm.globals.set("fake.countryCode", response.text());
});

pm.sendRequest(fakerServerOrigin + "/?property=internet.exampleEmail", function (err, response) {
    pm.globals.set("fake.email", response.text());
});

pm.sendRequest(fakerServerOrigin + "/?property=random.uuid", function (err, response) {
    pm.globals.set("fake.uuid", response.text());
});

pm.sendRequest(fakerServerOrigin + "/?property=random.number", function (err, response) {
    pm.globals.set("fake.integer", response.text());
});
