import { useEffect } from "react"
import { useSelector } from "react-redux"
import { Button, Card, CardBody, CardHeader } from "reactstrap"
import AddLessonFormContainer from "./AddLessonForm/AddLessonForm.container"
import Class from './Editor.module.css'
import LessonItemContainer from "./LessonItem/LessonItem.container"
import SaveChangesContainer from "./SaveChanges/SaveChanges.container"

function Editor(props: any) {

    const modal = useSelector(
        (state: any) => state.editor.modalWindow
    )

    return (
        <>
            <SaveChangesContainer />
            {
                props.adding == true &&
                <AddLessonFormContainer show={props.setAdding} ID={props.ID} />
            }
            <Card color={'light'} className={`p-3 ${modal == true && Class.no_scroll}`}>
                <div className={`${Class.info}`}>
                    <div className="column jc-center">
                        <h3>Редактирование расписания</h3>
                        <h4>Группа: {props.group}</h4>
                    </div>
                    <div className={`column gap-2 jc-center`}>
                        <Button
                            onClick={props.changeGroup}
                            color="success"
                        >
                            Изменить название группы
                        </Button>
                        <Button
                            onClick={props.sendScheldule}
                            color="success"
                        >
                            Отправить изменения
                        </Button>
                    </div>
                </div>
                <div className={`${Class.days}`}>
                    {
                        props.list.map(
                            (value: any, day_index: number) => {
                                return (
                                    <Card
                                        key={day_index}
                                        className={`${Class.day}`}
                                    >
                                        <CardHeader className={`${Class.day_header}`}>
                                            <p>{value.name}</p>
                                            <Button
                                                color="success"
                                                onClick={
                                                    () => {
                                                        props.addLesson(value.id)
                                                    }
                                                }
                                            >
                                                +
                                            </Button>
                                        </CardHeader>
                                        <CardBody>
                                            {
                                                value.list.map(
                                                    (value: any, lesson_index: number) => {
                                                        return (
                                                            <LessonItemContainer
                                                                key={lesson_index}
                                                                value={value}
                                                                lessonID={lesson_index}
                                                                dayID={day_index}
                                                            />
                                                        )
                                                    }
                                                )
                                            }
                                        </CardBody>
                                    </Card>
                                )
                            }
                        )
                    }
                </div>
            </Card>
        </>
    )
}

export default Editor