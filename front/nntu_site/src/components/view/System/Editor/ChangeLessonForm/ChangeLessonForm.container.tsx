import { useEffect, useState } from "react"
import { useDispatch, useSelector } from "react-redux"
import { Lesson, LessonForm, StringTime, Time } from "../../../../../models/editor.models"
import { setChange } from "../../../../../store/changeReducer"
import { setModalWindow } from "../../../../../store/editorReducer"
import { addLesson, changeLesson, delLesson } from "../../../../../store/scheduleReducer"
import ChangeLessonForm from "./ChangeLessonForm"

function ChangeLessonFormContainer(props: any) {

    const change = useSelector(
        (state: any) => state.change.value
    )

    const types = [
        'Лекция',
        'Практика',
        'Лаб. работа'
    ]

    const weeks = [
        'Четные',
        'Нечетные'
    ]

    const dispatch = useDispatch()

    useEffect(
        () => {
            dispatch(setModalWindow(true))
            return (
                () => {
                    dispatch(setModalWindow(false))
                }
            )
        }, []
    )

    const firstSchedule = useSelector(
        (state: any) => state.schedule.firstSchedule
    )

    const [error, setError] = useState({
        flag: false,
        name: false,
        time: false,
        type: false,
        timeFormat: false
    })

    let toggleError = () => setError({
        ...error,
        flag: !error.flag
    })

    let time_1: Time = {
        start: 0,
        finish: 0
    }
    let time_2: StringTime = {
        start: '',
        finish: ''
    }
    let flag = false

    for (let value of firstSchedule) {
        if (value.start == change.value.time.start && value.finish == change.value.time.finish) {
            time_1 = change.value.time
            flag = true
            break
        }
    }

    if (flag == false) {
        // console.log(1)
        let start = change.value.time.start
        let finish = change.value.time.finish

        let sHours = Math.floor(start / 60)
        let sMinutes = Math.floor(start % 60)
        let fHours = Math.floor(finish / 60)
        let fMinutes = Math.floor(finish % 60)

        start = ''
        finish = ''

        start += sHours >= 10 ? sHours : '0' + sHours
        start += ':'
        start += sMinutes >= 10 ? sMinutes : '0' + sMinutes
        finish += fHours >= 10 ? fHours : '0' + fHours
        finish += ':'
        finish += fMinutes >= 10 ? fMinutes : '0' + fMinutes

        time_2 = {
            start,
            finish
        }
    }

    // console.log({time_1, time_2, flag})

    const [form, setForm] = useState<LessonForm>({
        name: change.value.name,
        room: change.value.room,
        mentor: change.value.mentor.fullname,
        type: change.value.type,
        week: change.value.week,
        time_1,
        time_2
    })

    let onNameChange = (event: any) => {
        let value = event.target.value
        setForm({
            ...form,
            name: value
        })
    }

    let onTypeChange = (flag: boolean, value: any) => {
        if (flag == true) {
            if (value == form.type) {
                setForm(
                    {
                        ...form,
                        type: ''
                    }
                )
            }
            else {
                setForm({
                    ...form,
                    type: value
                })
            }
        }
        else {
            setForm({
                ...form,
                type: value.target.value
            })
        }
    }

    let onRoomChange = (event: any) => {
        let value = event.target.value
        setForm({
            ...form,
            room: value
        })
    }

    let onMentorChange = (event: any) => {
        let value = event.target.value
        setForm({
            ...form,
            mentor: value
        })
    }

    let onWeekChange = (flag: boolean, value: number, event?: any) => {
        if (flag == true) {
            if (value == -2) {
                setForm(
                    {
                        ...form,
                        week: {
                            even: !form.week?.even,
                            odd: form.week?.odd,
                            other: form.week?.other
                        }
                    }
                )
            }
            else if (value == -1) {
                setForm(
                    {
                        ...form,
                        week: {
                            even: form.week?.even,
                            odd: !form.week?.odd,
                            other: form.week?.other
                        }
                    }
                )
            }
        }
        else {
            let value = event.target.value
            setForm(
                {
                    ...form,
                    week: {
                        even: form.week?.even,
                        odd: form.week?.odd,
                        other: value
                    }
                }
            )
        }
    }

    let onStartChange = (event: any) => {
        let value = event.target.value
        let newForm = { ...form }
        if (form.time_1.start != 0) {
            newForm.time_1 = {
                start: 0,
                finish: 0
            }
        }
        newForm.time_2 = {
            start: value,
            finish: form.time_2.finish,
        }
        setForm(
            newForm
        )
    }

    let onFinishChange = (event: any) => {
        let value = event.target.value
        let newForm = { ...form }
        if (form.time_1.start != 0) {
            newForm.time_1 = {
                start: 0,
                finish: 0
            }
        }
        newForm.time_2 = {
            start: form.time_2.start,
            finish: value,
        }
        setForm(
            newForm
        )
    }

    let onTimeChange = (start: number, finish: number) => {
        let newForm = { ...form }
        if (form.time_2.start != '' || form.time_2.finish != '') {
            newForm.time_2 = {
                start: '',
                finish: ''
            }
        }
        newForm.time_1 = {
            start,
            finish
        }
        setForm(
            newForm
        )
    }

    let close = () => {
        dispatch(setChange({
            flag: false,
            dayID: -1,
            lessonID: -1,
            value: null
        }))
    }

    let closeByBack = (event: any) => {
        let id = event.target.id
        if (id == 'back') {
            close()
        }   
    }

    let deleteLesson = () => {
        dispatch(delLesson(change.dayID, change.value.id))
        close()
    }

    let ChangeLesson = () => {

        let flag: any = {
            flag: false,
            name: false,
            time: false,
            type: false,
            timeFormat: false
        }

        if (form.time_1.start == 0 && (form.time_2.start == '' || form.time_2.finish == '')) {
            flag.flag = true
            flag.time = true
        }
        if (form.name == '') {
            flag.flag = true
            flag.name = true
        }
        if (form.type == '') {
            flag.flag = true
            flag.type = true
        }

        let time: Time = {
            start: 0,
            finish: 0
        }

        if (form.time_1.start != 0) {
            time = { ...form.time_1 }
        }
        else {
            let start = form.time_2.start
            let finish = form.time_2.finish

            let startArray = start.split(':')
            let finishArray = finish.split(':')

            if (startArray.length != 2 || finishArray.length != 2) {
                flag.timeFormat = true
                setError({ ...flag })
            }
            else {

                let timeFlag =
                    (startArray[0].length < 3 && startArray[0].length > 0)
                    && (finishArray[0].length < 3 && finishArray[0].length > 0)
                    && startArray[1].length == 2
                    && finishArray[1].length == 2

                if (timeFlag == false) {
                    flag.flag = true
                    flag.timeFormat = true
                }
                else {
                    let sHours = parseInt(startArray[0])
                    let sMinutes = parseInt(startArray[1])
                    let fHours = parseInt(finishArray[0])
                    let fMinutes = parseInt(finishArray[1])

                    let sTime = sHours * 60 + sMinutes
                    let fTime = fHours * 60 + fMinutes

                    time = {
                        start: sTime,
                        finish: fTime
                    }
                }
            }
        }

        let room = form.room.replace(new RegExp(' ', 'g'), '')
        let rooms: any[] = room.split(',').filter(
            (value: any) => {
                if (/^\d+$/.test(value) == true) {
                    return parseInt(value)
                }
            }
        )
        room = rooms.join(', ')
        
        let week = form.week
        let weekOther = week.other.replace(new RegExp(' ', 'g'), '')
        console.log(weekOther)
        let weeks: any[] = weekOther.split(',').filter(
            (value: any) => {
                if (/^\d+$/.test(value) == true) {
                    return parseInt(value)
                }
            }
        )
        weekOther = weeks.join(', ')
        week.other = weekOther

        if (flag.flag == true) {
            setError({ ...flag })
            return
        }

        let lesson: Lesson = {
            name: form.name,
            type: form.type,
            room,
            time: time,
            week,
            mentor: {
                fullname: form.mentor
            }
        }

        if (change.value.id != undefined) {
            lesson.id = change.value.id
        }

        dispatch(changeLesson(change.dayID, change.lessonID, lesson))
        close()
    }

    let data = {
        types,
        weeks,
        firstSchedule,
        closeByBack,
        close,
        form,
        onNameChange,
        onRoomChange,
        onMentorChange,
        onTypeChange,
        onWeekChange,
        onStartChange,
        onFinishChange,
        onTimeChange,
        ChangeLesson,
        error,
        toggleError,
        deleteLesson
    }

    return (
        <ChangeLessonForm {...data} />
    )
}

export default ChangeLessonFormContainer