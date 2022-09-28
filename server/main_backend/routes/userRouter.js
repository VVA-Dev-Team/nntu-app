const Router = require('express')
const router = new Router()
const rateLimit = require('express-rate-limit')
const userController = require('../controllers/userController')
const authMiddleware = require('../middleware/AuthMiddleware')

const registrationLimiter = rateLimit({
    windowMs: 5 * 60 * 1000,
    max: 5,
    standardHeaders: true,
    legacyHeaders: false,
    message: 'Too many accounts created from this IP, please try again later',
})

const loginLimiter = rateLimit({
    windowMs: 5 * 60 * 1000,
    max: 5,
    standardHeaders: true,
    legacyHeaders: false,
    message: 'Too many accounts created from this IP, please try again later',
})


router.post('/registration', registrationLimiter, userController.registration)
router.post('/login', loginLimiter, userController.login)
router.get('/', authMiddleware, userController.check)


module.exports = router