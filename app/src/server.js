const express = require('express');
const os = require('os');
const app = express();

app.get('/', (req, res) => {
  res.json({
    message: 'Hello from microservice',
    hostname: os.hostname(),
    timestamp: new Date().toISOString()
  });
});

app.get('/health', (req, res) => res.status(200).send('OK'));

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Listening on ${port}`));
