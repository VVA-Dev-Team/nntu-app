export interface Mentor {
    fullname: string,
    lasname?: string,
    firstname?: string,
    patronim?: string
}

export interface Week {
    even: boolean,
    odd: boolean,
    other: string
}

export interface LessonForm {
    name: string,
    room: string,
    mentor: string,
    type: string,
    week: Week,
    time_1: Time,
    time_2: StringTime
}

export interface StringTime {
    start: string,
    finish: string
}

export interface Time {
    start: number,
    finish: number
}

export interface Lesson {
    name: string,
    type: string,
    room: string,
    time: Time,
    mentor: Mentor,
    week: Week,
    comment?: string,
    id?: number
}

export interface Day {
    id: number,
    name: string,
    list: Lesson[]
}