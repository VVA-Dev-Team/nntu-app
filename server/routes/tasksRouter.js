const Router = require('express')
const router = new Router()
const tasksController = require('../controllers/tasksController')


router.post('/', tasksController.addTask)
router.get('/', tasksController.getTask)
router.delete('/', tasksController.deleteTask)
router.put('/', tasksController.editTask)


module.exports = router