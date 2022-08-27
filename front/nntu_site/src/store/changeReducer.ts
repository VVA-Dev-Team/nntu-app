const SET_CHANGE = 'SET_CHANGE' 
const SET_SENDING = 'SET_SENDING'

export let setChange = (value: any) => {
    return({
        type: SET_CHANGE,
        value
    })
}

export let setSending = (value: any) => {
    return({
        type: SET_SENDING,
        value
    })
}

let initialState = {
    value: {
        flag: false,
        dayID: -1,
        lessonID: -1,
        value: null
    },
    sending: false
}

let changeReducer = (state = initialState, action: any) => {
    switch(action.type) {
        case SET_CHANGE: {
            // debugger
            return({
                ...state,
                value: action.value
            })
        }
        case SET_SENDING: {
            // debugger
            return({
                ...state,
                sending: action.value
            })
        }
        default: {
            return({
                ...state
            })
        }
    }
}

export default changeReducer