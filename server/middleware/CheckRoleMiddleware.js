const jwt = require('jsonwebtoken')

module.exports = function(role) {
    return function (req, res, next) {
        if (res.method == 'OPTIONS') {
            next()
        }
        try {
            const token = req.headers.authorization.split(' ')[1]
            if (!token) {
                res.status(401).json({message: "Не авторизован"})
            }
            const decoded = jwt.verify(token, process.env.SECRET_KEY)
            if (decoded.role !== role) {
                res.status(401).json({message: "Не авторизован"})
            }
            req.user = decoded
            next()
        } catch (e) {
            res.status(403).json({message: "Не авторизован"})
        }
    }
}