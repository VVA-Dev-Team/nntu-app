const Router = require('express')
const router = new Router()
const rateLimit = require('express-rate-limit')
const marksRouter = require('./marksRouter')
const scheduleRouter = require('./scheduleRouter')
const eventsRouter = require('./eventsRouter')
const tasksRouter = require('./tasksRouter')
const userRouter = require('./userRouter')

const openApiLimiter = rateLimit({
    windowMs: 15 * 60 * 1000,
    max: 150,
    standardHeaders: true,
    legacyHeaders: false,
    message: 'Too many accounts created from this IP, please try again later',
})

const marksApiLimiter = rateLimit({
    windowMs: 15 * 60 * 1000,
    max: 50,
    standardHeaders: true,
    legacyHeaders: false,
    message: 'Too many accounts created from this IP, please try again later',
})



router.use('/marks', marksApiLimiter, marksRouter)
router.use('/schedule', openApiLimiter, scheduleRouter)
router.use('/events', openApiLimiter, eventsRouter)
router.use('/tasks', openApiLimiter, tasksRouter)
router.use('/user', userRouter)


module.exports = router