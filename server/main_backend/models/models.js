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
    weeks: {type: DataTypes.STRING},
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
    color: {type: DataTypes.STRING, defaultValue: ''}
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

const Post = sequelize.define('posts',
    {
        id: {type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true},
        vk_id: {type: DataTypes.INTEGER, unique: true, allowNull: false},
        title: {type: DataTypes.TEXT, unique: false, allowNull: false},
        text: {type: DataTypes.TEXT, unique: false, allowNull: true},
        date: {type: DataTypes.STRING, unique:false, allowNull: false},
    })

const Media = sequelize.define('medias',
    {
        id: {type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true},
        link: {type: DataTypes.STRING, unique: false, allowNull: false}
    })

Post.hasMany(Media)
Media.belongsTo(Post)


// const Group = sequelize.define('group', {
//     id: {type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true},
//     name: {type: DataTypes.STRING, unique: true},
// })
//
// const Headman = sequelize.define('headman', {
//     id: {type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true},
//     student_number: {type: DataTypes.STRING, unique: true},
// })
//
// const StudentOrganizationCategory = sequelize.define('student_organization_category', {
//     id: {type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true},
//     name: {type: DataTypes.STRING, unique: true},
// })
//
// const StudentOrganization = sequelize.define('student_organization', {
//     id: {type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true},
//     name: {type: DataTypes.STRING, unique: true},
//     description: {type: DataTypes.TEXT},
//     owner: {type: DataTypes.STRING},
//     vkLink: {type: DataTypes.STRING},
//     whoCanJoin: {type: DataTypes.STRING},
//     cost: {type: DataTypes.STRING},
//     institute: {type: DataTypes.STRING},
//     department: {type: DataTypes.STRING},
// })


module.exports = {
    Schedule, Events, Tasks, User, Media, Post
}