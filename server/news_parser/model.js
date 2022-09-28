const sequelize = require('./db')
const {DataTypes} = require('sequelize')

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

module.exports = {
    Post,
    Media
}