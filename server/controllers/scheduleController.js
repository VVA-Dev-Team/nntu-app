const ApiError = require("../error/ApiError");
const {Schedule} = require('../models/models')
const {Op} = require('sequelize');


class ScheduleController {
    async getSchedule(req, res, next) {
        try {
            const {group, week_number} = req.query
            let schedule = []
            if (week_number) {
                for (let i = 0; i < 7; i++) {
                    schedule.push(await Schedule.findAll({
                        where: {
                            group,
                            day: i,
                            weeks: {[Op.contains]: [week_number]}
                        }
                    }))
                }
            } else {
                for (let i = 0; i < 7; i++) {
                    schedule.push(await Schedule.findAll({where: {group, day: i}}))
                }
            }

            // const schedule = await Schedule.findAll({where: {group}})
            return res.json(schedule)
        } catch (e) {
            console.log(e)
            // return next(ApiError.bedRequest('Не заданы параметры'))
            return next(ApiError.badRequest(e))
        }
    }

    async editSchedule(req, res, next) {
        try {
            const {
                schedule,
                deleted_schedule,
                group_password,
            } = req.body
            let resSchedule = []
            if (group_password == '123') {
                if (deleted_schedule) {
                    for (let i = 0; i < deleted_schedule.length; i ++) {
                        let id = deleted_schedule[i]
                        await Schedule.destroy({
                            where: {
                                id
                            }
                        })
                    }
                }
                for (let i = 0; i < schedule.length; i++) {
                    for (let j = 0; j < schedule[i].length; j++) {
                        const id = schedule[i][j]['id']
                        if (id) {
                            const group = schedule[i][j]['group']
                            const name = schedule[i][j]['name']
                            const type = schedule[i][j]['type']
                            const room = schedule[i][j]['room']
                            const startTime = schedule[i][j]['startTime']
                            const stopTime = schedule[i][j]['stopTime']
                            const day = schedule[i][j]['day']
                            const weeks = schedule[i][j]['weeks']
                            const teacher = schedule[i][j]['teacher']
                            const comment = schedule[i][j]['comment']
                            resSchedule.push(await Schedule.update({
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
                            }, {where: {id: id}}))
                        } else {
                            const group = schedule[i][j]['group']
                            const name = schedule[i][j]['name']
                            const type = schedule[i][j]['type']
                            const room = schedule[i][j]['room']
                            const startTime = schedule[i][j]['startTime']
                            const stopTime = schedule[i][j]['stopTime']
                            const day = schedule[i][j]['day']
                            const weeks = schedule[i][j]['weeks']
                            const teacher = schedule[i][j]['teacher']
                            const comment = schedule[i][j]['comment']
                            resSchedule.push(await Schedule.create({
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
                            }))
                        }

                    }
                }

                return res.json(resSchedule)
            } else {
                return next(ApiError.forbidden('Не правильно введен код группы'))
            }

        } catch (e) {
            console.log(e)
            // return next(ApiError.bedRequest('Не заданы параметры'))
            return next(ApiError.internal(e))
        }
    }

    async addSchedule(req, res, next) {
        try {
            const {
                schedule,
                group_password,
            } = req.body
            let resSchedule = []
            if (group_password == '123') {

                for (let i = 0; i < schedule.length; i++) {
                    for (let j = 0; j < schedule[i].length; j++) {
                        const group = schedule[i][j]['group']
                        const name = schedule[i][j]['name']
                        const type = schedule[i][j]['type']
                        const room = schedule[i][j]['room']
                        const startTime = schedule[i][j]['startTime']
                        const stopTime = schedule[i][j]['stopTime']
                        const day = schedule[i][j]['day']
                        const weeks = schedule[i][j]['weeks']
                        const teacher = schedule[i][j]['teacher']
                        const comment = schedule[i][j]['comment']
                        resSchedule.push(await Schedule.create({
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
                        }))
                    }
                }

                return res.json(resSchedule)
            } else {
                return next(ApiError.forbidden('Не правильно введен код группы'))
            }

        } catch (e) {
            console.log(e)
            // return next(ApiError.bedRequest('Не заданы параметры'))
            return next(ApiError.internal(e))
        }
    }

    async deleteSchedule(req, res, next) {
        try {
            const {
                id,
                group_password,
            } = req.body
            if (group_password == '123') {
                const schedule = await Schedule.destroy({
                    where: {
                        id
                    }
                })

                return res.json(schedule)
            } else {
                return next(ApiError.forbidden('Не правильно введен код группы'))
            }
        } catch (e) {
            console.log(e)
            return next(ApiError.internal('Не заданы параметры'))
        }
    }
}

module.exports = new ScheduleController()