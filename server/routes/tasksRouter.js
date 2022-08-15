const Router = require('express')
const router = new Router()
const tasksController = require('../controllers/tasksController')


router.post('/', tasksController.addTask)
router.get('/', tasksController.getTask)
router.delete('/', tasksController.deleteTask)


module.exports = router