const db = require('../db/dbConfig')

/**
 * Finds a user by their username.
 * @param {string} username - The username of the user to find.
 * @returns {Promise<object|null>} The user object if found, otherwise null.
 */
const findUserByUsername = async (username) => {
  try {
    const query = 'SELECT * FROM users WHERE username = $1'

    const user = await db.oneOrNone(query, username)

    return user
  } catch (error) {
    console.error('Error finding user by username:', error)
    throw error
  }
}

// probably need to add is_tutor (to frontend as well)
// ---- original kept for reference ----
// const createUser = async ({ username, password_hash, email }) => {
//   const query = `
//       INSERT INTO users (username, password_hash, email)
//       VALUES ($1, $2, $3 )
//       RETURNING id, username, email; 
//     `
//   const newUser = await db.one(query, [username, password_hash, email])
//   return newUser
// }

const createUser = async ({ username, password_hash, email, is_tutor }) => {
  const query = `
      INSERT INTO users (username, password_hash, email, is_tutor)
      VALUES ($1, $2, $3, $4)
      RETURNING id, username, email, is_tutor; 
    `
  const newUser = await db.one(query, [username, password_hash, email, is_tutor])
  return newUser
}

module.exports = {
  findUserByUsername,
  createUser,
}
