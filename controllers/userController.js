const express = require('express');
const user = express.Router();
const { findUserByUsername } = require('../queries/users');
const { authenticateToken } = require('../middlewares/authenticateToken');

user.get('/', authenticateToken, async (req, res) => {
  res.json({ message: 'User controller' });
});

// probably security risk lol because you can see the password hashes, but route works. Not sure if we need this for the app. Maybe we can modify fx to see just the usernames without all the data so instead of user object just user.username should suffice
user.get('/:username', authenticateToken, async (req, res) => {
  try {
    const { username } = req.params;

    const user = await findUserByUsername(username);

    if (user) {
      res.status(200).json({ username: user.username });
    } else {
      res.status(404).json({ message: 'User not found' });
    }
  } catch (error) {
    console.error('Error finding user by username:', error);
    res.status(500).json({ message: 'Internal server error' });
  }
});

module.exports = user;