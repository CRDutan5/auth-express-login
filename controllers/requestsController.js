// requestsController.js
const express = require('express');
const requestsRouter = express.Router();
const { getRequestsById } = require("../queries/requests");

// renamed fx for clarity - we don't need a get all because this is particular to logged in tutor
requestsRouter.get('/:id', async (req, res) => {
  const { id } = req.params;

  const requests = await getRequestsById(id);
  res.json(requests);
});


module.exports = requestsRouter;
