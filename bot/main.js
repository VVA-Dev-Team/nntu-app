require('dotenv').config()
const TelegramBot = require('node-telegram-bot-api')

const start = () => {
    const bot = new TelegramBot(process.env.TOKEN, {polling: true})

    bot.onText(/\/start/, (msg) => {
        bot.sendMessage(msg.chat.id, "Привет! Я бот помощник сервиса NNTU App, помогаю быстро получить код для загрузки расписания. Просто отправь мне название твоей группы так же, как ты указывал в редакторе.");
    });

    bot.on('message', (msg) => {
        if (msg.text !== '/start') {


            const chatId = msg.chat.id;

            const date = new Date()
            let encodedText = ''

            const string = msg.text
            const alphabet = process.env.ALPHABET

            console.log(typeof process.env.SECRET_KEY)

            let i = 0;
            while (i < string.length) {
                if (alphabet.indexOf(string[i]) !== -1) {
                    const alphabetIndex = alphabet.indexOf((string[i]).toUpperCase());
                    if (alphabet[alphabetIndex + (date.getDate() + parseInt(process.env.SECRET_KEY))]) {
                        encodedText += alphabet[alphabetIndex + (date.getDate() + parseInt(process.env.SECRET_KEY))];
                    } else {
                        encodedText += alphabet[alphabetIndex + (date.getDate() + parseInt(process.env.SECRET_KEY)) - 75];
                    }
                } else {
                    encodedText += string[i];
                }
                i++;
            }

            console.log(encodedText)

            bot.sendMessage(chatId, `Твой код: ${encodedText}\nОн действителен в течении сегодняшнего дня`);
        }
    });

}

start()