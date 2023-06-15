const express = require('express')
const app = express()

app.use(express.json())

app.get("/service2/api/data", (req, res) => { 
    res.status(200).json({msg: 'hello from service2'})
})

app.listen(3080, ()=> { 
    console.log('listening on 3080')
})