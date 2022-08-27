import { Badge, Button, Card, CardBody, CardHeader } from "reactstrap"
import LessonItemContainer from "./LessonItem/LessonItem.container"

import Class from './Schedule.module.css'
import arrow from '../../../../assets/photos/arrow.png'

function Schedule(props: any) {

    return (
        <>
            <Card className={`p-3`}>
                <div className={`${Class.info}`}>
                    <div className="column jc-center">
                        <h3>Расписание</h3>
                        <h4>Группа: {props.group}</h4>
                    </div>
                    <div className={`${Class.counter}`}>
                        <Badge
                            onClick={props.lastWeek}
                            className={`${Class.arrow} ${Class.left}`}
                        >
                            <img src={arrow} />
                        </Badge>
                        <Badge className={`${Class.week}`}>{props.week}</Badge>
                        <Badge
                            onClick={props.nextWeek}
                            className={`${Class.arrow}`}
                        >
                            <img src={arrow} />
                        </Badge>
                    </div>
                </div>
                <div className={`${Class.scroll}`}>
                    <div className={`${Class.days}`}>
                        {
                            props.weekList?.map(
                                (value: any, day_index: number) => {
                                    return (
                                        <Card
                                            key={day_index}
                                            className={`${Class.day}`}
                                        >
                                            <CardHeader className={`${Class.day_header}`}>
                                                <p>{value.name}</p>
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
                </div>
            </Card>
        </>
    )
}

export default Schedule