const Router = require('express')
const router = new Router()
const scheduleController = require('../controllers/scheduleController')


router.post('/', scheduleController.addSchedule)
router.get('/', scheduleController.getSchedule)
router.delete('/', scheduleController.deleteSchedule)
router.put('/', scheduleController.editSchedule)


module.exports = router