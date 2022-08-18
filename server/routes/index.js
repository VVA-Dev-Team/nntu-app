const Router = require('express')
const router = new Router()
const marksRouter = require('./marksRouter')
const scheduleRouter = require('./scheduleRouter')
const eventsRouter = require('./eventsRouter')
const tasksRouter = require('./tasksRouter')
const userRouter = require('./userRouter')

router.use('/marks', marksRouter)
router.use('/schedule', scheduleRouter)
router.use('/events', eventsRouter)
router.use('/tasks', tasksRouter)
router.use('/user', userRouter)


module.exports = router