const ApiError = require("../error/ApiError");
const {Schedule} = require('../models/models')
const {Op} = require('sequelize');


class ScheduleController {
    async getSchedule(req, res, next) {
        try {
            const {group, week_number} = req.query
            let schedule = []
            for (let i = 0; i < 7; i++) {
                schedule.push(await Schedule.findAll({where: {group, day: i, weeks: {[Op.contains]: [week_number]}}}))
            }
            // const schedule = await Schedule.findAll({where: {group}})
            return res.json(schedule)
        } catch (e) {
            console.log(e)
            return next(ApiError.bedRequest('Не заданы параметры'))
        }
    }

    async editSchedule(req, res, next) {
        try {
            const {
                id,
                group,
                name,
                type,
                room,
                startTime,
                stopTime,
                day,
                weeks,
                teacher,
                comment,
                group_password
            } = req.body
            if (group_password == '123') {
                const schedule = await Schedule.update({
                    group,
                    name,
                    type,
                    room,
                    startTime,
                    stopTime,
                    day,
                    weeks,
                    teacher,
                    comment
                }, {where: {id: id}})
                return res.json(schedule)
            } else {
                return next(ApiError.forbidden('Не правильно введен код группы'))
            }

        } catch (e) {
            console.log(e)
            return next(ApiError.bedRequest('Не заданы параметры'))
        }
    }

    async addSchedule(req, res, next) {
        try {
            const {
                group,
                name,
                type,
                room,
                startTime,
                stopTime,
                day,
                weeks,
                teacher,
                comment,
                group_password
            } = req.body
            if (group_password == '123') {
                const schedule = await Schedule.create({
                    group,
                    name,
                    type,
                    room,
                    startTime,
                    stopTime,
                    day,
                    weeks,
                    teacher,
                    comment
                })
                return res.json(schedule)
            } else {
                return next(ApiError.forbidden('Не правильно введен код группы'))
            }

        } catch (e) {
            console.log(e)
            return next(ApiError.bedRequest('Не заданы параметры'))
        }
    }

    async deleteSchedule(req, res, next) {
        try {
            const {id} = req.body
            const schedule = await Schedule.destroy({
                where: {
                    id
                }
            })
            return res.json(schedule)
        } catch (e) {
            console.log(e)
            return next(ApiError.bedRequest('Не заданы параметры'))
        }
    }
}

module.exports = new ScheduleController()