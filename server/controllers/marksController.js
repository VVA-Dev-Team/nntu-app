const cheerio = require('cheerio');
const request = require('request');
const ApiError = require('../error/ApiError')

class MarksController {
    async getMarks(req, res, next) {
        const query = req.query
        if (!query['last_name'] || !query['first_name'] || !query['otc'] || !query['n_zach'] || !query['last_name']) {
            return next(ApiError.badRequest('Не заданы параметры'))
        }
        var options = {
            'method': 'POST',
            'url': 'https://www.nntu.ru/frontend/web/student_info.php',
            'headers': {
                'Connection': 'keep-alive',
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'
            },
            formData: {
                'last_name': query.last_name,
                'first_name': query.first_name,
                'otc': query.otc,
                'n_zach': query.n_zach,
                'learn_type': query.learn_type,
            }
        };
        await request(options, function (error, response) {
            if (error) throw new Error(error);
            if (response.body.includes('Студент не найден.')) {
                return next(ApiError.forbidden('Студент не найден'))
            }
            if (response.statusCode !== 200) {
                return next(ApiError.internal('Непредвиденная ошибка'))
            } else {
                console.log(response.body)
                console.log(response.statusCode)
                try {
                    var scrapedData = {
                        marks: [],
                        stat: {
                            predmets: {},
                            average: 0,
                            term: []
                        },
                    }
                    const $ = cheerio.load(response.body, null, false);

                    $('table').each((index2, element2) => {
                        const el = cheerio.load(element2, null, false);
                        var table = []
                        el('tbody > tr').each((index, element) => {
                            const tds = $(element).find('td')
                            if ($(tds[0]).text() !== '' && $(tds[0]).text() !== 'Дисциплина' && $(tds[0]).text() !== ':'
                                && $(tds[0]).text() !== 'Факультет ' && $(tds[0]).text() !== 'Курс' && $(tds[0]).text() !== 'Группа'
                                && $(tds[0]).text() !== '\n                      ' && $(tds[0]).text() !== '(оценка)') {
                                const predmet = $(tds[0]).text().trim()
                                const kn1 = {mark: $(tds[1]).text().trim() || -1, leave: $(tds[2]).text().trim()}
                                const kn2 = {mark: $(tds[3]).text().trim() || -1, leave: $(tds[4]).text().trim()}
                                const session = $(tds[5]).text().trim()
                                const typeOfAttestation = $(tds[6]).text().trim()
                                const tableRow = {predmet, kn1, kn2, session, typeOfAttestation}
                                table.push(tableRow)
                            }
                        })
                        if (table.length !== 0) {
                            scrapedData['marks'].push(table)
                        }

                    })
                    var index = 0
                    var average = 0
                    var count = 0
                    scrapedData['marks'].forEach(function (semester) {
                        index += 1
                        var termAverage = 0
                        var termCount = 0
                        semester.forEach(function (el) {
                            if (el['session'] >= '0' && el['session'] <= '5') {
                                if (el['predmet'] in scrapedData['stat']) {
                                    scrapedData['stat']['predmets'][el['predmet']].push(Number(el['session']))
                                    average += Number(el['session'])
                                    count += 1
                                    termAverage += Number(el['session'])
                                    termCount += 1
                                } else {
                                    scrapedData['stat']['predmets'][el['predmet']] = []
                                    scrapedData['stat']['predmets'][el['predmet']].push(Number(el['session']))
                                    average += Number(el['session'])
                                    count += 1
                                    termAverage += Number(el['session'])
                                    termCount += 1
                                }
                            }
                        })
                        scrapedData['stat']['term'].push(isNaN((termAverage / termCount).toFixed(2)) ? '-' : (termAverage / termCount).toFixed(2))
                    })
                    scrapedData['stat']['average'] = (average / count).toFixed(2);
                    res.json(scrapedData)
                } catch (e) {
                    return next(ApiError.internal(`${e}`))
                }
            }


        });

    }
}

module.exports = new MarksController()