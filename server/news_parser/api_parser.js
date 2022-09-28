let request = require('request')
const {Post, Media} = require('./model')

let token = process.env.VK_TOKEN

const sequelize = require('./db')

const start = async () => {
    try {
        await sequelize.authenticate()
        await sequelize.sync()
        console.log('sync')
    }
    
    catch (e) {
        console.log(e)
    }
}
start()


setInterval(() => {
    let url = 'https://api.vk.com/method/wall.get?access_token=' + token + '&v=5.131&domain=nntualekseeva'

    let posts = []

    request.get({url: url}, (error, response, body) => {

        if (error != null) return
    
        let json = JSON.parse(body)

        json.response.items.forEach(item => {

            post_info = {
                vk_id: undefined,
                title: 'title',
                text: undefined,
                date: undefined,
                images: []
            }

            post_info.vk_id = item.id
            post_info.text = item.text
            if (post_info.text.indexOf('\n') > 0){
                post_info.title = post_info.text.split('\n')[0]
                post_info.text = post_info.text.split('\n')
                post_info.text.shift()
                post_info.text = post_info.text.join('\n')
            }
            let datum = new Date(item.date * 1000)
            post_info.date = datum.toLocaleString()
            post_info.date = post_info.date.slice(0, post_info.date.length - 3)
            if (item.attachments != undefined){
                item.attachments.forEach(attachment => {
                    if (attachment.type == 'photo') {
                        let best_size = attachment.photo.sizes[0].width
                        let best_index = 0

                        for (let i = 1; i < attachment.photo.sizes.length; i++) {
                            if (attachment.photo.sizes[i] > best_size){
                                best_size = size.width
                                best_index = i
                            }
                        }
                        post_info.images.push(attachment.photo.sizes[best_index].url)
                    }
                })
            }
            posts.push(post_info)
        });
        
        posts.forEach(async (post) => {
            let already_exists
            await Post.count({where: {vk_id: post.vk_id}}).then((count) => {
                already_exists = (count != 0)
            })
            if (!already_exists){
                let postid = await Post.create({vk_id: post.vk_id, text: post.text, date: post.date, title: post.title})
                postid = postid.toJSON().id

                post.images.forEach(async (image) => {
                    Media.create({link: image, postId: postid})
                }) 
            }
        })
    })
}, 10000)