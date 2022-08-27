import { lazy } from "react"    
import SystemContainer from "../components/view/System/System.container"

const EditorContainer = lazy(() => import('../components/view/System/Editor/Editor.container'))
const FindGroupContainer = lazy(() => import('../components/view/System/FindGroup/FindGroup.container'))
const ScheduleContainer = lazy(() => import('../components/view/System/Schedule/Schedule.container'))

export const routes = [
    '/schedule',
    '/editor',
    '/group'
]

const MainRouter = [
    {
        path: '/',
        element: <SystemContainer />,
        children: [
            {
                path: '/schedule',
                element: <ScheduleContainer />
            },
            {
                path: '/editor',
                element: <EditorContainer />
            },
            {
                path: '/group',
                element: <FindGroupContainer />
            }
        ]
    }
]

export default MainRouter