const db = require('../db/dbConfig');

const showStudentReviews = async () => {
    try {
        const reviews = await db.any("SELECT * FROM student_reviews");
        return reviews;
    } catch (error){
        return error;
    }
};
const showStudentReview = async (id) => {
    try {
        const oneReview = await db.one("SELECT * FROM student_reviews WHERE id=$1", id);
        return oneReview;
    } catch (error){
        return error;
    }
};

module.exports = { 
    showStudentReviews,
    showStudentReview
};
