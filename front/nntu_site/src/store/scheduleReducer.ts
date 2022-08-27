import { Lesson } from "../models/editor.models"
import GroupService from "../services/group.service"

const ADD_LESSON = 'ADD_LESSON'
const CHANGE_LESSON = 'CHANGE_LESSON'
const CHANGE_GROUP = 'CHANGE_GROUP'
const SET_SCHEDULE = 'SET_SCHEDULE'
const DELETE_LESSON = 'DELETE_LESSON'

export let addLesson = (dayID: number, lesson: Lesson) => {
    return (
        {
            type: ADD_LESSON,
            value: lesson,
            dayID
        }
    )
}

export let changeLesson = (dayID: number, lessonID: number, lesson: Lesson) => {
    return (
        {
            type: CHANGE_LESSON,
            dayID,
            lessonID,
            value: lesson
        }
    )
}
export let changeGroup = (value: string) => {
    return ({
        type: CHANGE_GROUP,
        value
    })
}

export let setSchedule = (value: any) => {
    return ({
        type: SET_SCHEDULE,
        value
    })
}

export let delLesson = (dayID: number, lessonID: number) => {
    return ({
        type: DELETE_LESSON,
        dayID,
        lessonID
    })
}

let initialState = {
    group: '',
    list: [
        {
            name: 'Понедельник',
            id: 0,
            list: [
                {
                    name: 'Графические информационные технологии',
                    type: 'Хз пока',
                    room: '6034',
                    mentor: {
                        fullname: 'Козлов Роман Васильевич'
                    },
                    time: {
                        start: 460,
                        finish: 545
                    },
                    week: {
                        even: true,
                        odd: true,
                        other: ''
                    }
                }
            ]
        },
        {
            name: 'Вторник',
            id: 1,
            list: [

            ]
        },
        {
            name: 'Среда',
            id: 2,
            list: [

            ]
        },
        {
            name: 'Четверг',
            id: 3,
            list: [

            ]
        },
        {
            name: 'Пятница',
            id: 4,
            list: [

            ]
        },
        {
            name: 'Суббота',
            id: 5,
            list: [

            ]
        },
        {
            name: 'Воскресение',
            id: 6,
            list: [

            ]
        }
    ],
    firstSchedule: [
        {
            start: 450,
            finish: 545
        },
        {
            start: 560,
            finish: 655
        },
        {
            start: 670,
            finish: 765
        },
        {
            start: 795,
            finish: 890
        },
        {
            start: 900,
            finish: 995
        },
        {
            start: 1005,
            finish: 1100
        },
        {
            start: 1110,
            finish: 1205
        },
    ],
    secondSchedule: [
        {
            start: 450,
            finish: 545
        },
        {
            start: 560,
            finish: 655
        },
        {
            start: 670,
            finish: 765
        },
        {
            start: 795,
            finish: 890
        },
        {
            start: 900,
            finish: 995
        },
        {
            start: 1005,
            finish: 1100
        },
        {
            start: 1110,
            finish: 1205
        },
    ]
}

let scheduleReducer = (state: any = initialState, action: any) => {

    state = JSON.parse(JSON.stringify(state))

    switch (action.type) {
        case ADD_LESSON: {

            let dayID = action.dayID
            let newList = state.list

            newList[dayID].list.push(
                { ...action.value }
            )

            newList[dayID].list.sort(
                (a: Lesson, b: Lesson) => a.time?.start - b.time?.start
            )

            let obj = {
                ...state,
                list: newList
            }

            GroupService.setSchedule(obj.list)

            return (obj)
        }
        case CHANGE_LESSON: {

            let dayID = action.dayID
            let lessonID = action.lessonID
            let newList = state.list

            newList[dayID].list[lessonID] = { ...action.value }

            let obj = {
                ...state,
                list: newList
            }

            GroupService.setSchedule(obj.list)

            return (obj)
        }
        case CHANGE_GROUP: {
            return ({
                ...state,
                group: action.value
            })
        }
        case SET_SCHEDULE: {

            let obj = {
                ...state,
                list: action.value
            }

            return (obj)
        }
        case DELETE_LESSON: {

            let newList = [...state.list]
            newList[action.dayID].list = newList[action.dayID].list.filter(
                (value: any) => {
                    if (value.id != action.lessonID) {
                        return value
                    }
                }
            )

            let obj = {
                ...state,
                list: newList
            }

            GroupService.setSchedule(obj.list, action.lessonID)

            return (obj)
        }
        default: {
            return (
                { ...state }
            )
        }
    }
}

export default scheduleReducer