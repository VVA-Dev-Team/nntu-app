import Class from './Header.module.css'
import logo from '../../../assets/photos/logo.png'
import { useEffect, useState } from 'react'
import { Collapse, Dropdown, DropdownItem, DropdownMenu, DropdownToggle, Nav, Navbar, NavbarBrand, NavbarToggler, NavItem, NavLink } from 'reactstrap'
import { Link, useNavigate } from 'react-router-dom'

function Header(props: any) {

    const navigator = useNavigate()

    const [opened, setOpened] = useState(false)
    const toggle = () => setOpened(!opened)

    let routes = [
        {
            name: 'Редактор расписания',
            to: '/editor'
        },
        {
            name: 'Расписание',
            to: '/schedule'
        },
        {
            name: 'События',
            to: '/events'
        }
    ]

    let goToRoute = (to: string) => {
        navigator(to)
    }

    return (
        <header>
            <Navbar color="faded" light>
                <div className={`${Class.block} container center`}>
                    <NavbarBrand href="/" className={`${Class.logo}`}>
                        <img src={logo} />
                    </NavbarBrand>
                    {/* <NavbarToggler onClick={toggle} className="me-2" /> */}
                    <Dropdown isOpen={opened} toggle={toggle}>
                        <DropdownToggle caret>Меню</DropdownToggle>
                        <DropdownMenu>
                            {
                                routes.map(
                                    (value: any, index: number) => {
                                        return (
                                            <DropdownItem
                                                key={index}
                                                onClick={
                                                    () => {
                                                        goToRoute(value.to)
                                                    }
                                                }
                                            >
                                                {value.name}
                                            </DropdownItem>
                                        )
                                    }
                                )
                            }
                        </DropdownMenu>
                    </Dropdown>
                </div>
                {/* <div className={`container center`}>
                    <Collapse isOpen={!opened} navbar>
                        <Nav navbar>
                            <NavItem>
                                <Link to="/editor">Редактор расписания</Link>
                            </NavItem>
                            <NavItem>
                                <Link to="/schedule">Расписание</Link>
                            </NavItem>
                            <NavItem>
                                <Link to="/events">События</Link>
                            </NavItem>
                        </Nav>
                    </Collapse>
                </div> */}
            </Navbar>
            {/* <header className={`${Class.Header}`}>
                <div className={`${Class.block} container center`}>
                    <div className={`${Class.logo}`}>
                        <img src={logo} />
                    </div>
                    <Dropdown isOpen={opened} toggle={toggle} >
                        <DropdownToggle caret>Настройки</DropdownToggle>
                    </Dropdown>
                </div>

            </header> */}

        </header>
    )
}

export default Header