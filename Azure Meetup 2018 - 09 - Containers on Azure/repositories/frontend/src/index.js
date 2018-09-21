'use strict';

const express = require('express');
const morgan = require('morgan');
const got = require('got');
const os = require('os');

const port = process.env.PORT || 3000;
const backendURL = 'http://whiteduck-api';
const app = express();

/**
 * Middleware configuration
 */
app.use(morgan('combined'));

/**
 * Routing
 */
app.get('/', (req, res) => {
	got(`${backendURL}/health`, { json: true })
		.then((apiResponse) => {
			const response = {
				version: 'v1',
				status: 'OK',
				request: {
					url: apiResponse.url,
					method: 'GET',
					reponse: { body: apiResponse.body, statusCode: apiResponse.statusCode },
				},
				hostname: os.hostname(),
			};

			res.status(200)
				.send(response);
		}).catch((error) => {
			res.status(500)
				.send(error);
		});
});

/**
 * Start app
 */
app.listen(port, () => {
	console.log(`Whiteduck AKS testing app listening on port ${port}!`);
});
