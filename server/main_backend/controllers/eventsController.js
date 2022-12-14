const {Events} = require("../models/models");
const ApiError = require("../error/ApiError");
const uuid = require('uuid');
const path = require('path')
const {Post} = require("../../news_parser/model");

class EventsController {
    async getEvents(req, res, next) {
        try {
            const eventByAdmin = await Events.findAll({
                order: [['updatedAt', 'DESC']]
            })
            const posts = await Post.findAll({order: [['updatedAt', 'DESC']], limit: 20})
            const  events = {
                "events": eventByAdmin,
                "posts": posts
            }
            return res.json(events)
        } catch (e) {
            console.log(e)
            return next(ApiError.internal('Непредвиденная ошибка'))
        }
    }

    async addEventsByAdmin(req, res, next) {
        try {
            const {
                title,
                description,
                type,
                startTime,
                link,
                color,
            } = req.body
            const {img} = req.files
            let fileName = uuid.v4() + ".jpg"
            await img.mv(path.resolve(__dirname, '..', 'static/events', fileName))
            const schedule = await Events.create({
                title,
                description,
                type,
                startTime,
                fileName,
                link,
                color,
            })
            return res.json(schedule)
        } catch (e) {
            console.log(e)
            return next(ApiError.badRequest('Не заданы параметры'))
        }
    }

    async editEvents(req, res, next) {
        try {
            const {
                id,
                title,
                description,
                type,
                startTime,
                link,
                color,
                oldFileName,
                addedBy,
            } = req.body
            let fileName
            try {
                const {img} = req.files
                fileName = uuid.v4() + ".jpg"
                await img.mv(path.resolve(__dirname, '..', 'static/events', fileName))
            } catch (e) {
                fileName = oldFileName
            }
            const schedule = await Events.update({
                title,
                description,
                type,
                startTime,
                fileName,
                link,
                color,
                addedBy: addedBy,
            }, {where: {id: id}})
            return res.json(schedule)
        } catch (e) {
            console.log(e)
            return next(ApiError.badRequest('Не заданы параметры'))
        }
    }

    async deleteEvents(req, res, next) {
        try {
            const {id} = req.body
            const event = await Events.destroy({
                where: {
                    id
                }
            })
            return res.json(event)
        } catch (e) {
            console.log(e)
            return next(ApiError.badRequest('Не заданы параметры'))
        }
    }
}

module.exports = new EventsController()