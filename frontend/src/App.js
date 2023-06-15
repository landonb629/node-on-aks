import logo from './logo.svg';
import './App.css';
import {useState} from 'react'
import styled from 'styled-components'

function App() {
  const [service1, setService1] = useState()
  const [service2, setService2] = useState()

  const Wrapper = styled.div`
    color: #A0A0A0;
    text-align: center;
    h3 { 
      padding-bottom: 25px;
      border-bottom: 2px solid #FA8925;
    }
    button { 
      margin: 20px;
      width: 150px;
      border-radius: 15px;
      box-shadow: 5px 5px 5px;
    }
    button:hover { 
      background-color: #FA8925;
    }
    h2{ 
      color: #FA8925;
    }
  `

  const service1fetch = async () => { 
      const data = await fetch("service1/api/data")
      console.log(data)
      const response = await data.json();
      console.log(response.msg)
      setService1(response.msg)
  }

  const service2fetch = async () => { 
    const data = await fetch("service2/api/data")
    console.log(data)
    const response = await data.json()
    setService2(response)
  }

  return (
    <Wrapper> 
      <div className="flex-container">
        <div className="flex-item">
          <h1>Sample App</h1>
          <h3>react / node apps running in AKS</h3>
        </div>
        <button onClick={()=> service1fetch()}>Service 1</button>
        <button onClick={()=> service2fetch()}>Service 2</button>
      </div>
      <div className='flex-item'> 
          <h2>{service1}</h2>
          <h2>{service2}</h2>
      </div>
    </Wrapper>
  )
}

export default App;
