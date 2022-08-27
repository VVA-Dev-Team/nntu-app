import { useDispatch, useSelector } from "react-redux"
import { setChange } from "../../../../../store/changeReducer"
import LessonItem from "./LessonItem"

function LessonItemContainer(props: any) {

    const dispatch = useDispatch()

    const change = useSelector(
        (state: any) => state.change.value
    )

    let data = {
        value: props.value,
        index: props.lessonID,
        change
    }

    return (
        <LessonItem {...data} />
    )
}

export default LessonItemContainer