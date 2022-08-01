const Router = require('express')
const router = new Router()
const marksRouter = require('./marksRouter')

router.use('/marks', marksRouter)


module.exports = router