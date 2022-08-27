import { API_URL } from "../config/api.confige";

import axios from 'axios'
import { Day, Lesson } from "../models/editor.models";
import CookieService from "./cookie.service";

const SCHEDULE_API = `${API_URL}/schedule`


interface LessonData {
    id?: number,
    group?: string,
    name?: string,
    type?: string,
    room?: string,
    startTime?: number,
    stopTime?: number,
    day?: number,
    weeks?: number[],
    teacher?: string,
    comment?: string
}

interface SendData {
    deleted_schedule?: any[],
    schedule?: any[],
    group_password?: string
}

export default class GroupService {

    static getSchedule(group: string) {
        return axios.get(`${SCHEDULE_API}?group=${group}`)
    }
    static getFormattedSchedule(group: string): Promise<any> {
        return new Promise(
            (resolve) => {
                let array = this.getSchedule(group).then(
                    res => {
                        let days = [
                            'Понедельник',
                            'Вторник',
                            'Среда',
                            'Четверг',
                            'Пятница',
                            'Суббота',
                            'Воскресение'
                        ]
                        let schedule = res.data
                        // console.log(schedule)
                        let newSchedule = schedule.map(
                            (value: any, index: number) => {
                                let list: Lesson[] = value.map(
                                    (value: any, index: number) => {

                                        let week = {
                                            even: true,
                                            odd: true,
                                            other: ''
                                        }

                                        let even = value.weeks.indexOf(-2)
                                        let odd = value.weeks.indexOf(-1)

                                        if (even == -1) {
                                            week.even = false
                                        }
                                        if (odd == -1) {
                                            week.even = false
                                        }

                                        let newWeeks = value.weeks.filter(
                                            (value: number) => value != -1 && value != -2
                                        )

                                        week.other = newWeeks.join(', ')

                                        return ({
                                            id: value.id,
                                            name: value.name,
                                            type: value.type,
                                            room: value.room,
                                            time: {
                                                start: value.startTime,
                                                finish: value.stopTime
                                            },
                                            mentor: {
                                                fullname: value.teacher
                                            },
                                            week,
                                            comment: value.comment
                                        })
                                    }
                                )
                                let day: Day = {
                                    id: index,
                                    name: days[index],
                                    list
                                }
                                return day
                            }
                        )
                        return newSchedule
                    }
                )
                resolve(array)
            }
        )
    }
    static sendFormattedSchedule(code: any): Promise<any> {
        let group = CookieService.getCookie('group')
        let list = JSON.parse(window.localStorage.schedule).list
        let deleted = JSON.parse(window.localStorage.deleted)
        let data: SendData = {}
        data.deleted_schedule = deleted
        data.group_password = code
        let schedule = list.map(
            (day: any, day_index: number) => {
                let newDay = day.list.map(
                    (lesson: Lesson, lesson_index: number) => {
                        let newLesson: LessonData = {}
                        if (lesson.id != undefined) {
                            newLesson.id = lesson.id
                        }
                        //@ts-ignore
                        newLesson.group = group
                        newLesson.name = lesson.name
                        newLesson.type = lesson.type
                        newLesson.room = lesson.room
                        newLesson.startTime = lesson.time.start
                        newLesson.stopTime = lesson.time.finish
                        newLesson.day = day_index
                        newLesson.teacher = lesson.mentor.fullname
                        newLesson.comment = lesson.comment == undefined ? '' : lesson.comment

                        let weeks = []

                        if (lesson.week.even == true) {
                            weeks.push(-2)
                        }
                        if (lesson.week.odd == true) {
                            weeks.push(-1)
                        }

                        let other = lesson.week.other.split(', ').map(
                            value => {
                                return parseInt(value)
                            }
                        )

                        weeks.push(...other)

                        newLesson.weeks = weeks

                        return newLesson
                    }
                )
                return newDay
            }
        )
        data.schedule = schedule
        return axios.put(`${SCHEDULE_API}`, data)
    }
    static setSchedule(value: any, deleted = -1) {

        if (deleted != -1) {
            this.addDeleted(deleted)
        }
        let obj = {
            list: value
        }
        window.localStorage.setItem('schedule', JSON.stringify(obj))
    }
    static addDeleted(value: number) {
        let deleted = JSON.parse(window.localStorage.deleted)
        deleted.push(value)
        window.localStorage.setItem('deleted', JSON.stringify(deleted))
    }
    static createDeleted() {
        window.localStorage.setItem('deleted', JSON.stringify([]))
    }
}