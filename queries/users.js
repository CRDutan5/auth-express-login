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
const createUser = async ({ user_name, passwordHash, email }) => {
  const query = `
      INSERT INTO users (user_name, password_hash, email)
      VALUES ($1, $2, $3 )
      RETURNING id, username, email; 
    `
  const newUser = await db.one(query, [user_name, passwordHash, email])
  return newUser
}

module.exports = {
  findUserByUsername,
  createUser,
}
