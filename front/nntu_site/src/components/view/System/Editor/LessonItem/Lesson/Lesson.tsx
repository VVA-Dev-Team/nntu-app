import { Badge } from 'reactstrap'
import Class from './Lesson.module.css'

function Lesson(props: any) {

    return (
        <div className={`${Class.Lesson}`} onClick={props.changeLesson}>
            <p
                className={`${Class.time}`}
            >
                {props.time}
            </p>
            <div className={`${Class.info}`}>
                <h5 className={`${Class.name} m-0`}>
                    {props.name}
                </h5>
                <hr />
                {
                    (props.week.even == true || props.week.odd == true || props.week.other != '')
                    &&
                    <div className={`${Class.weeks} mt-1`}>
                        {
                            props.week.even == true
                            &&
                            <Badge color='primary'>ЧН</Badge>
                        }
                        {
                            props.week.odd == true
                            &&
                            <Badge color='success'>НЧ</Badge>
                        }
                    </div>
                }
                {
                    props.week.other != ''
                    &&
                    <>
                        +
                        <Badge>  {props.week.other}</Badge>

                    </>
                }
                {
                    props.type != ''
                    &&
                    <p className='m-0'>
                        Тип занятия: <b>{props.type}</b>
                    </p>
                }
                {
                    props.room != ''
                    &&
                    <p className='m-0'>
                        Аудитория: <b>{props.room}</b>
                    </p>
                }
                {
                    props.mentor.fullname != ''
                    &&
                    <>
                        <p className='m-0'>
                            Преподаватель:
                        </p>
                        <h6 className={`${Class.name} m-0`}>
                            {props.mentor.fullname}
                        </h6></>
                }

            </div>
        </div>
    )
}

export default Lesson