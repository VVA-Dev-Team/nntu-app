import Class from './LessonItem.module.css'
import LessonContainer from "./Lesson/Lesson.container"

function LessonItem(props: any) {

    return (
        <div
            className={`${Class.block}`}
        >
            {
                props.index != 0 &&
                <hr className={`${Class.line}`} />
            }
            <LessonContainer
                {...props.value}
            />
        </div>
    )
}

export default LessonItem