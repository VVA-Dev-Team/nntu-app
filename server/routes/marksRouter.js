const Router = require('express')
const router = new Router()
const marksController = require('../controllers/marksController')


router.get('/', marksController.getMarks)


module.exports = router