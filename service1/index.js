const express = require('express')
const app = express()

app.use(express.json())

app.get("/api/data", (req, res) => { 
    res.status(200).json({msg: 'responding from service1!'})
})

app.listen(3080, ()=> { 
    console.log('listening on 3080')
})