import { useEffect, useMemo, useState } from "react"
import { useDispatch, useSelector } from "react-redux"
import { useNavigate } from "react-router"
import { Day, Lesson, Time } from "../../../../models/editor.models"
import CookieService from "../../../../services/cookie.service"
import GroupService from "../../../../services/group.service"
import { setSending } from "../../../../store/changeReducer"
import { setSchedule } from "../../../../store/scheduleReducer"
import Editor from "./Editor"

function EditorContainer(props: any) {

    const navigate = useNavigate()
    const dispatch = useDispatch()

    const name: string = useSelector(
        (state: any) => state.schedule.name
    )

    const group: string = useSelector(
        (state: any) => state.schedule.group
    )

    const list: any[] = useSelector(
        (state: any) => state.schedule.list
    )

    const firstShedule: Time[] = useSelector(
        (state: any) => state.schedule.firstSchedule
    )

    const [adding, setAdding] = useState(false)
    const [ID, setID] = useState(-1)

    let addLesson = (dayID: number) => {
        setAdding(true)
        setID(dayID)
    }

    let changeGroup = () => {
        CookieService.deleteCookie('group')
        navigate('/group')
    }

    let sendScheldule = () => {
        dispatch(setSending(true))
    }


    useEffect(
        () => {
            
        }, []
    )

    let data = {
        list,
        name,
        group,
        adding,
        setAdding,
        addLesson,
        ID,
        changeGroup,
        sendScheldule
    }

    return (
        <Editor {...data} />
    )
}

export default EditorContainer