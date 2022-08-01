require('dotenv').config()
const express = require('express')
const cors = require('cors')
const router = require('./routes/index')
const errorHandler = require('./middleware/ErrorHandlingMiddleware')

// для https
const fs = require('fs');
const http = require('http');
const https = require('https');

const PORT = process.env.PORT || 5000

const app = express()
app.use(cors())
app.use('/api', router)
app.use('/static', express.static('images'))


// всегда в конце (обработка ошибок)
app.use(errorHandler)


const start = async () => {
    try {
        if (process.env.HTTPS == 1) {
            // Certificate
            const privateKey = fs.readFileSync('/etc/letsencrypt/live/yourdomain.com/privkey.pem', 'utf8');
            const certificate = fs.readFileSync('/etc/letsencrypt/live/yourdomain.com/cert.pem', 'utf8');
            const ca = fs.readFileSync('/etc/letsencrypt/live/yourdomain.com/chain.pem', 'utf8');

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