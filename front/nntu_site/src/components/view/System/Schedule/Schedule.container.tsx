import { useEffect, useState } from "react"
import { useSelector } from "react-redux"
import Schedule from "./Schedule"

function ScheduleContainer(props: any) {

    const group: string = useSelector(
        (state: any) => state.schedule.group
    )
    const list: any[] = useSelector(
        (state: any) => state.schedule.list
    )
    const [weekList, setWeekList] = useState<any>([])

    const [week, setWeek] = useState(1)

    let lastWeek = () => {
        if (week != 1) {
            setWeek(prev => prev - 1)
        }
    }

    let nextWeek = () => {
        setWeek(prev => prev + 1)
    }

    let setList = (weekNumber: number) => {

        let evenFlag = weekNumber % 2 == 0

        let newList = list.map(
            (value: any, index: number) => {
                let lessons = value.list.filter(
                    (lesson: any, lesson_index: number) => {
                        let week = lesson.week
                        let flag = false
                        if (evenFlag == true) {
                            if (week.even == true){
                                flag = true
                            }
                        }
                        else {
                            if (week.odd == true){
                                flag = true
                            }
                        }
                        let other = week.other.split(', ').map(
                            (value: any) => {
                                return parseInt(value)
                            }
                        )
                        if (other.indexOf(weekNumber) != -1) {
                            flag = true
                            console.log({other, name: lesson.name})
                        }
                        if (flag == true) {
                            return lesson
                        }
                    }
                )
                return {
                    ...value,
                    list: lessons
                }
            }
        )

        // console.log(newList)

        setWeekList(newList)

    }

    useEffect(
        ()=> {
            setList(week)
        }, [week]
    )

    useEffect(
        () => {
            setList(1)
        }, [list]
    )

    let data = {
        weekList,
        group,
        week,
        lastWeek,
        nextWeek
    }

    return (
        <Schedule {...data} />
    )
}

export default ScheduleContainer