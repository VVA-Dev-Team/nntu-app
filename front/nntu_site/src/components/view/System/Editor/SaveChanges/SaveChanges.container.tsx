import { useState } from "react"
import { useDispatch, useSelector } from "react-redux"
import GroupService from "../../../../../services/group.service"
import { setSending } from "../../../../../store/changeReducer"
import { setSchedule } from "../../../../../store/scheduleReducer"
import SaveChanges from "./SaveChanges"

function SaveChangesContainer (props: any) {

    const dispatch = useDispatch()

    const sending = useSelector(
        (state: any) => state.change.sending
    )
    const group: string = useSelector(
        (state: any) => state.schedule.group
    )

    let toggler = () => dispatch(setSending(!sending))

    const [code, setCode] = useState('')
    const [error, setError] = useState(false)

    let onCodeChange = (event: any) => {
        let value = event.target.value
        setCode(value)
    }

    let onInputFocus = () => {
        if (error == true) {
            setError(false)
        }
    }

    let sendChanges = (event: any) => {
        if (code == '') {
            setError(true)
        }
        else {
            GroupService.sendFormattedSchedule(code).then(
            (res: any) => {
                console.log(res)
                GroupService.createDeleted()
                GroupService.getFormattedSchedule(group).then(
                    res => {
                        console.log(res)
                        GroupService.setSchedule(res)
                        dispatch(setSchedule(res))
                        toggler()
                    }
                )
            }
        )
        }
    }

    let data = {
        sending,
        toggler,
        code,
        onCodeChange,
        error,
        onInputFocus,
        sendChanges
    }

    return(
        <SaveChanges {...data}/>
    )
}

export default SaveChangesContainer