import Lesson from "./Lesson"

function LessonContainer (props: any) {

    let start = props.time.start
    let finish = props.time.finish

    let sHours = Math.floor(start / 60)
    let sMinutes = Math.floor(start % 60)
    let fHours = Math.floor(finish / 60)
    let fMinutes = Math.floor(finish % 60)

    start = ''
    finish = ''

    start += sHours >= 10 ? sHours : '0' + sHours 
    start += ':'
    start += sMinutes >= 10 ? sMinutes : '0' + sMinutes
    finish += fHours >= 10 ? fHours : '0' + fHours 
    finish += ':'
    finish += fMinutes >= 10 ? fMinutes : '0' + fMinutes

    let time = start + ' - ' + finish

    let data = {
        ...props,
        start, 
        finish,
        time,
        changeLesson: props.changeLesson
        // index: props.index
    }

    return(
        <Lesson {...data}/>
    )
}

export default LessonContainer