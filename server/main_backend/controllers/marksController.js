const cheerio = require('cheerio');
const request = require('request');
const ApiError = require('../error/ApiError')

class MarksController {
    async getMarks(req, res, next) {
        const query = req.query
        if (!query['last_name'] || !query['first_name'] || !query['otc'] || !query['n_zach'] || !query['learn_type']) {
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
                return next(ApiError.internal('Непредвиденная ошибка. StatusCode = ', response.statusCode))
            }

            //console.log('response = ', response.body)

            let scrapedData = {
                marks: [],
                stat: {
                    predmets: {},
                    average: 0,
                    term: []
                },
            }

            // try {
            const $ = cheerio.load(response.body, null, false);

            $('table.table').each((tableIndex, table) => {
                table = cheerio.load(table, null, false);
                var predmetsInTable = []

                let headers = 0

                table('tbody > tr.table_header').each((tableheaderIndex, tableheader) => {
                    headers += 1
                })

                if (headers === 2) {
                    table('tbody > tr.tr_class').each((tablerowIndex, tablerow) => {
                        tablerow = cheerio.load(tablerow, null, false)
                        const tds = tablerow('*').find('td')

                        // console.log({
                        //     predmet: tablerow(tds[0]).text().trim() || '-',
                        //     kn1: {
                        //         mark: tablerow(tds[1]).text().trim() || '-',
                        //         leave: tablerow(tds[2]).text().trim() || '-'
                        //     },
                        //     kn2: {
                        //         mark: tablerow(tds[3]).text().trim() || '-',
                        //         leave: tablerow(tds[4]).text().trim() || '-'
                        //     },
                        //     session: tablerow(tds[5]).text().trim() || '-',
                        //     typeOfAttestation: tablerow(tds[6]).text().trim() || '-'
                        // })

                        predmetsInTable.push({
                            predmet: tablerow(tds[0]).text().trim() || '-',
                            kn1: {
                                mark: tablerow(tds[1]).text().trim() || '-',
                                leave: tablerow(tds[2]).text().trim() || '-'
                            },
                            kn2: {
                                mark: tablerow(tds[3]).text().trim() || '-',
                                leave: tablerow(tds[4]).text().trim() || '-'
                            },
                            session: tablerow(tds[5]).text().trim() || '-',
                            typeOfAttestation: tablerow(tds[6]).text().trim() || '-'
                        })

                    })
                } else {
                    table('tbody > tr.tr_class').each((tablerowIndex, tablerow) => {
                        tablerow = cheerio.load(tablerow, null, false)
                        const tds = tablerow('*').find('td')

                        // console.log({
                        //     predmet: tablerow(tds[0]).text().trim() || '-',
                        //     session: tablerow(tds[1]).text().trim() || '-',
                        //     typeOfAttestation: tablerow(tds[2]).text().trim() || '-'
                        // })

                        predmetsInTable.push({
                            predmet: tablerow(tds[0]).text().trim() || '-',
                            kn1: {
                                mark: '-',
                                leave: '-'
                            },
                            kn2: {
                                mark: '-',
                                leave: '-'
                            },
                            session: tablerow(tds[1]).text().trim() || '-',
                            typeOfAttestation: tablerow(tds[2]).text().trim() || '-'
                        })
                    })
                }

                if (predmetsInTable.length !== 0) {
                    scrapedData['marks'].push(predmetsInTable)
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
            // console.log(scrapedData)
            res.json(scrapedData)
            // } catch (e) {
            //     return next(ApiError.internal(`${e}`))
            // }
        })
    }
}

module.exports = new MarksController()