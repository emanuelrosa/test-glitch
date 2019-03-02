// --------------------------

// debug

// console.log(`${process.env.GLITCH_URL}`)
// console.log(`${process.env.GLITCH_TOKEN}`)
// console.log(`${process.env.GLITCH_PROJECT_ID}`)
// console.log(`${process.env.GLITCH_REPO}`)
// console.log(`${process.env.GLITCH_PATH}`)

const request = require('request')

const options = {
  method: 'POST',
  url: `https://api.${process.env.GLITCH_URL}/project/githubImport`,
  qs: {
    authorization: process.env.GLITCH_TOKEN,
    projectId: process.env.GLITCH_PROJECT_ID,
    repo: process.env.GLITCH_REPO,
    path: process.env.GLITCH_PATH
  },
  headers: {
    'cache-control': 'no-cache',
    origin: `https://${process.env.GLITCH_URL}`,
    referer: `https://${process.env.GLITCH_URL}/edit/`,
    accept: '*/*'
  }
}

request(options, function (error, response, body) {

  // debug
  // if (error) throw new Error(error);
  // console.log(body);

  if (body === 'OK') {
    console.log('Sucess to sync changes in your bot')
    process.exit(0)
  } else {
    console.error('Fail to sync changes in your bot')
    process.exit(1)
  }

})

// --------------------------