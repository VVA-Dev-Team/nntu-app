import { setGroupValue } from "../../../../store/editorReducer"
import { useEffect, useState } from "react"
import { useDispatch } from "react-redux"
import { useLocation, useNavigate } from "react-router"
import FindGroup from "./FindGroup"
import CookieService from "../../../../services/cookie.service"
import { changeGroup, setSchedule } from "../../../../store/scheduleReducer"
import GroupService from "../../../../services/group.service"

function FindGroupContainer(props: any) {

    const navigate = useNavigate()
    const dispatch = useDispatch()
    const location = useLocation()

    const [flag, setFlag] = useState(true)
    const [group, setGroup] = useState('')
    const [error, setError] = useState(false)

    let toggle = () => setFlag(!flag)

    let onGroupChange = (event: any) => {
        let value = event.target.value
        setGroup(value)
    }

    let saveGroup = () => {
        if (group == '') {
            setError(true)
        }
        else {
            document.cookie = `group=${group}`
            GroupService.getFormattedSchedule(group).then(
                (res: any) => {
                    GroupService.createDeleted()
                    GroupService.setSchedule(res)
                    dispatch(setSchedule(res))
                    dispatch(changeGroup(group))
                    console.log(location.pathname)
                    navigate('/editor')
                }
            )
        }
    }

    let onInputFocus = () => {
        if (error == true) {
            setError(false)
        }
    }

    useEffect(
        () => {
            
        }, []
    )

    let data = {
        flag,
        toggle,
        group,
        onGroupChange,
        saveGroup,
        error,
        onInputFocus
    }

    return (
        <FindGroup {...data} />
    )
}

export default FindGroupContainer