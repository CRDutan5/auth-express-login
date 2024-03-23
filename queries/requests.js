const db = require("../db/dbConfig")

const getAllRequests = async () => {
    try{
        const allRequests = await db.any("SELECT * FROM requests");
        return allRequests;
    } catch (error){
        return error;
    }
}

module.exports = {
    getAllRequests
}