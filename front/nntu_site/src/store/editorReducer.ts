export const SET_MODAL_WINDOW = 'SET_MODAL_WINDOW'
export const SET_GROUP = 'SET_GROUP'

export let setModalWindow = (value: boolean) => {
    return(
        {
            type: SET_MODAL_WINDOW,
            value
        }
    )
}

export let setGroupValue = (value: string) => {
    return(
        {
            type: SET_GROUP,
            value
        }
    )
}

let initialState = {
    modalWindow: false,
    group: ''
}

let editorReducer = (state: any = initialState, action: any) => {
    switch(action.type) {
        case SET_MODAL_WINDOW: {
            return(
                {
                    ...state,
                    modalWindow: action.value
                }
            )
        }
        case SET_GROUP: {
            return(
                {
                    ...state,
                    group: action.value
                }
            )
        }
        default: {
            return(
                {...state}
            )
        }
    }
}

export default editorReducer