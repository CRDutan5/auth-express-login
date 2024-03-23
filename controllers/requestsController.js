const express = require('express')
const requests = express.Router()

const {getAllRequests} = require("../queries/requests");

requests.get('/', async (req, res) => {
    const allRequests = await getAllRequests();
    if (allRequests[0])res.status(200).json(allRequests)
})

module.exports = requests