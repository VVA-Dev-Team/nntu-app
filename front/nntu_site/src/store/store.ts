import { configureStore } from "@reduxjs/toolkit";
import changeReducer from "./changeReducer";
import editorReducer from "./editorReducer";
import scheduleReducer from "./scheduleReducer";

export default configureStore({
    reducer: {
        schedule: scheduleReducer,
        editor: editorReducer,
        change: changeReducer
    }
})