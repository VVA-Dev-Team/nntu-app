const sequelize = require('../db')
const {DataTypes} = require('sequelize')

const Schedule = sequelize.define('schedule', {
    id: {type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true},
    group: {type: DataTypes.STRING},
    name: {type: DataTypes.STRING},
    type: {type: DataTypes.STRING},
    room: {type: DataTypes.STRING, defaultValue: ''},
    startTime: {type: DataTypes.INTEGER},
    stopTime: {type: DataTypes.INTEGER},
    day: {type: DataTypes.INTEGER},
    weeks: {type: DataTypes.ARRAY(DataTypes.INTEGER)},
    teacher: {type: DataTypes.STRING, defaultValue: ''},
    comment: {type: DataTypes.STRING, defaultValue: ''},
})

const Events = sequelize.define('events', {
    id: {type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true},
    title: {type: DataTypes.STRING},
    description: {type: DataTypes.TEXT, defaultValue: ''},
    type: {type: DataTypes.STRING},
    startTime: {type: DataTypes.STRING, defaultValue: ''},
    fileName: {type: DataTypes.STRING},
    link: {type: DataTypes.STRING, defaultValue: ''},
    color: {type: DataTypes.STRING, defaultValue: ''},
    addedBy: {type: DataTypes.STRING, defaultValue: 'SYSTEM'}
})

const Tasks = sequelize.define('tasks', {
    id: {type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true},
    group: {type: DataTypes.STRING},
    title: {type: DataTypes.STRING},
    description: {type: DataTypes.TEXT, defaultValue: ''},
    lessonName: {type: DataTypes.STRING},
    priority: {type: DataTypes.STRING},
    stopDate: {type: DataTypes.STRING, defaultValue: ''},
    addedByStudent: {type: DataTypes.STRING, defaultValue: ''}
})

const User = sequelize.define('user', {
    id: {type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true},
    email: {type: DataTypes.STRING, unique: true},
    password: {type: DataTypes.STRING},
    role: {type: DataTypes.STRING},
})

module.exports = {
    Schedule, Events, Tasks, User
}