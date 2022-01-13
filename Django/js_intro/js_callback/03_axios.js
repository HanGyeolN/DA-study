const axios = require('axios')

axios.get('https://jsonplaceholder.typicode.com/posts')
    .then(response => { // 자동으로 response로 get 요청에대한 응답이 들어온다
        console.log(response)
    })
    .catch(err =>{
        console.log(err)
    }) // 에러 처리