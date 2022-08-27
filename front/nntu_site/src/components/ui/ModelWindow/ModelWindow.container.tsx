import ModelWindow from "./ModelWindow"

interface ModelWindowProps {
    element: any,
    show: any
}

function ModelWindowContainer (props: ModelWindowProps) {

    let closeWindow = () => {
        props.show(false)
    }

    let data = {
        element: props.element,
        closeWindow
    }

    return(
        <ModelWindow {...data}/>
    )
}

export default ModelWindowContainer