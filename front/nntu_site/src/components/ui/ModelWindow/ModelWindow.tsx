import { Button, Card } from 'reactstrap'
import Class from './ModelWindow.module.css'

import close from '../../../assets/photos/close.png'

function ModelWindow(props: any) {

    return (
        <div className={`${Class.ModelWindow}`}>


            <Card className={`p-3 ${Class.block}`}>

                <div>
                    {props.element}
                </div>
                {/* <Button onClick={props.closeWindow}>Click</Button> */}
                <div className={`${Class.close}`}>
                    <img src={close} />
                </div>
            </Card>
        </div>
    )
}

export default ModelWindow