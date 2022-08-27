import { Outlet } from "react-router"
import HeaderContainer from "../../ui/Header/Header.container"

function System(props: any) {

    return (
        <div>
            <HeaderContainer />
            <hr className="container mb-3" />
            <div className="container center">
                <Outlet></Outlet>
            </div>

        </div>
    )
}

export default System