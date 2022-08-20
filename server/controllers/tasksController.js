const ApiError = require("../error/ApiError");
const {Tasks} = require('../models/models')


class TasksController {
    async getTask(req, res, next) {
        try {
            const {group} = req.query
            const tasks = await Tasks.findAll({where: {group}})
            return res.json(tasks)
        } catch (e) {
            console.log(e)
            return next(ApiError.bedRequest('Не заданы параметры'))
        }
    }

    async addTask(req, res, next) {
        try {
            const {
                group,
                title,
                type,
                description,
                lessonName,
                priority,
                stopDate,
                addedByStudent
            } = req.body
            const schedule = await Tasks.create({
                group,
                title,
                type,
                description,
                lessonName,
                priority,
                stopDate,
                addedByStudent
            })
            return res.json(schedule)

        } catch (e) {
            console.log(e)
            return next(ApiError.bedRequest('Не заданы параметры'))
        }
    }

    async editTask(req, res, next) {
        try {
            const {
                id,
                group,
                title,
                type,
                description,
                lessonName,
                priority,
                stopDate,
                addedByStudent
            } = req.body
            const schedule = await Tasks.update({
                group,
                title,
                type,
                description,
                lessonName,
                priority,
                stopDate,
                addedByStudent
            }, {where: {id: id}})
            return res.json(schedule)

        } catch (e) {
            console.log(e)
            return next(ApiError.bedRequest('Не заданы параметры'))
        }
    }

    async deleteTask(req, res, next) {
        try {
            const {id} = req.query
            const tasks = await Tasks.destroy({
                where: {
                    id
                }
            })
            return res.json(tasks)
        } catch (e) {
            console.log(e)
            return next(ApiError.bedRequest('Не заданы параметры'))
        }
    }
}

module.exports = new TasksController()