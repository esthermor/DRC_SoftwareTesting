# DRC Software Testing

### Project Description

This repository is created for software testing on kaching.one as BeSquare 2022's DRC Final Project.<br />
Website : https://kaching.one<br />

### Install dependencies

Install jest and supertest:<br />
`npm install --save-dev jest supertest`<br />
<br />
In package.json, add portion: <br />

```bash
"jest":{
  "testEnvironment" : "node"
  }

 "scripts": {
  "test" : "jest"
 }
```

### Run test
#### API Testing
Run test with `npm test`
#### Automation Testing
Run test with Robotframework: `robot <filename.robot>`
