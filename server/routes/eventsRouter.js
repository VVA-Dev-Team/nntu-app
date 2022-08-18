const Router = require('express')
const router = new Router()
const eventsController = require('../controllers/eventsController')
const checkRole = require('../middleware/CheckRoleMiddleware')


router.post('/', checkRole('ADMIN'), eventsController.addEventsByAdmin)
router.post('/system', eventsController.addEventsBySystem)
router.get('/', eventsController.getEvents)
router.delete('/', checkRole('ADMIN'), eventsController.deleteEvents)
router.put('/', checkRole('ADMIN'), eventsController.editEvents)


module.exports = router