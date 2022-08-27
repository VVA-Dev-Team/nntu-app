import Class from './LessonItem.module.css'
import LessonContainer from "./Lesson/Lesson.container"
import ChangeLessonFormContainer from "../ChangeLessonForm/ChangeLessonForm.container"

function LessonItem(props: any) {

    return (
        <div
            className={`${Class.block}`}
        >
            {
                props.change.flag == true
                &&
                <ChangeLessonFormContainer />
            }
            {
                props.index != 0 &&
                <hr className={`${Class.line}`} />
            }
            <LessonContainer
                {...props.value}
                changeLesson={props.changeLesson}
            />
        </div>
    )
}

export default LessonItem