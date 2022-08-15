require('dotenv').config()
const express = require('express')
const cors = require('cors')
const fileUpload = require('express-fileupload')
const router = require('./routes/index')
const errorHandler = require('./middleware/ErrorHandlingMiddleware')
const sequelize = require('./db')
const models = require('./models/models')

// для https
const fs = require('fs');
const http = require('http');
const https = require('https');

const PORT = process.env.PORT || 5000

const app = express()
app.use(cors())
app.use(express.json())
app.use(fileUpload({}))
app.use('/api', router)
app.use('/static', express.static('static'))


// всегда в конце (обработка ошибок)
app.use(errorHandler)


const start = async () => {
    try {

        await sequelize.authenticate()
        await sequelize.sync()

        if (process.env.HTTPS == 1) {
            // Certificate
            const privateKey = fs.readFileSync('/etc/letsencrypt/live/nntuapp.api.vvadev.ru/privkey.pem', 'utf8');
            const certificate = fs.readFileSync('/etc/letsencrypt/live/nntuapp.api.vvadev.ru/cert.pem', 'utf8');
            const ca = fs.readFileSync('/etc/letsencrypt/live/nntuapp.api.vvadev.ru/chain.pem', 'utf8');

            const credentials = {
                key: privateKey,
                cert: certificate,
                ca: ca
            };

            // Starting both http & https servers
            const httpServer = http.createServer(app);
            const httpsServer = https.createServer(credentials, app);
            
            httpServer.listen(80, () => {
                console.log('HTTP Server running on port 80');
            });
            
            httpsServer.listen(443, () => {
                console.log('HTTPS Server running on port 443');
            });

        } else {
            app.listen(PORT, () => console.log(`Server started on port ${PORT}`))
        }
    } catch (e) {
        console.log(e)
    }
}

start()