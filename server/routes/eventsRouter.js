const Router = require('express')
const router = new Router()
const eventsController = require('../controllers/eventsController')


router.post('/', eventsController.addEventsByAdmin)
router.post('/system', eventsController.addEventsBySystem)
router.get('/', eventsController.getEvents)
router.delete('/', eventsController.deleteEvents)


module.exports = router