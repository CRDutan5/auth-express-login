const db = require('../db/dbConfig');

const showStudentReview = async (id) => {
    try {
        const oneReview = await db.one("SELECT * FROM student_reviews WHERE id=$1", id);
        return oneReview;
    } catch (error){
        return error;
    }
};

module.exports = { showStudentReview };
