import { useDispatch, useSelector } from "react-redux"
import { setChange } from "../../../../../store/changeReducer"
import LessonItem from "./LessonItem"

function LessonItemContainer(props: any) {

    const dispatch = useDispatch()

    const change = useSelector(
        (state: any) => state.change.value
    )

    function changeLesson() {
        dispatch(setChange({
            flag: true,
            dayID: props.dayID,
            lessonID: props.lessonID,
            value: props.value
        }))
    }

    let data = {
        value: props.value,
        index: props.lessonID,
        change,
        changeLesson
    }

    return (
        <LessonItem {...data} />
    )
}

export default LessonItemContainer