import { useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import { useLocation, useNavigate, useRoutes } from "react-router";
import { routes } from "../../../router/MainRouter";
import CookieService from "../../../services/cookie.service";
import { changeGroup, setSchedule } from "../../../store/scheduleReducer";
import System from "./System"

function SystemContainer(props: any) {

    const modal = useSelector(
        (state: any) => state.editor.modalWindow
    )

    const navigate = useNavigate()
    const location = useLocation()
    const dispatch = useDispatch()

    useEffect(
        () => {
            let value = CookieService.getCookie('group')
            if (value != null) {
                dispatch(changeGroup(value))
                let schedule = JSON.parse(window.localStorage.schedule)
                dispatch(setSchedule(schedule.list))
                console.log(location.pathname)
                let path = location.pathname
                if (path == '/') {
                    path = '/editor'
                }
                navigate(path)
            }
            else {
                navigate('/group')
            }
        }, []
    )

    useEffect(
        () => {
            if (modal == true) {
                document.body.style.overflow = 'hidden';
            }
            else {
                document.body.style.overflow = 'auto';
            }
        }, [modal]
    )

    return (
        <System />
    )
}

export default SystemContainer