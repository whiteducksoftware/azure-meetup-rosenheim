'use strict';

const express = require('express');
const os = require('os');
const morgan = require('morgan');

const port = process.env.PORT || 3000;
const app = express();

/**
 * Middleware configuration
 */
app.use(morgan('combined'));

/**
 * Routing
 */
app.get('/', (req, res) => {
	res.redirect('/health');
});

app.get('/health', (req, res) => {
	res.status(200)
		.json({
			health: 'OK',
			version: 'v2',
			os: os.platform(),
			arch: os.arch(),
			hostname: os.hostname(),
		});
});

/**
 * Start app
 */
app.listen(port, () => {
	console.log(`Whiteduck AKS testing app listening on port ${port}!`);
});
