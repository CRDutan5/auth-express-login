const express = require('express');
const studentReviews = express.Router();
const { showStudentReview } =require("../queries/studentreviews");

// Define route handler for /api/requests
studentReviews.get('/:id', async (req, res) => {
    const {id} = req.params;
    const review = await showStudentReview(id);
    if (review){
        res.json(review);
    } else {
        res.status(404).json({error: "not found"})
    }
});

module.exports = studentReviews;