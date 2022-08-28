require('dotenv').config()
const TelegramBot = require('node-telegram-bot-api')

const start = () => {
    const bot = new TelegramBot(process.env.TOKEN, {polling: true})

    

}