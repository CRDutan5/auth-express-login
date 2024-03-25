// queries/requests.js
const db = require('../db/dbConfig');

const getRequestsById = async (tutorId) => {
    console.log("query", tutorId)
    try {
        const tutorRequests = await db.any(
            "SELECT student.username AS student_name, student.id AS student_id, requests.accepted FROM requests INNER JOIN users AS tutor ON requests.tutor_id = tutor.id INNER JOIN users AS student ON requests.user_id = student.id WHERE tutor.id = $1",
            [tutorId]
        );
        console.log(tutorRequests)
        return tutorRequests;
    } catch (error) {
        console.error('Error fetching requests:', error);
        throw error;
    }
};

module.exports = { getRequestsById };
