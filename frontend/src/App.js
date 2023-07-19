import logo from './logo.svg';
import './App.css';
import {useState} from 'react'
import styled from 'styled-components'
import {AiFillCloseCircle} from 'react-icons/ai'
import {FaRegWindowClose} from 'react-icons/fa'


function App() {
  const [service1, setService1] = useState('')
  const [service2, setService2] = useState('')

  const Wrapper = styled.div`
    color: #A0A0A0;
    text-align: center;
    h3 { 
      padding-bottom: 25px;
      border-bottom: 2px solid #FA8925;
    }
    .trigger { 
      margin: 20px;
      width: 150px;
      border-radius: 15px;
      box-shadow: 5px 5px 5px;
    }
    .trigger:hover { 
      background-color: #FA8925;
    }
    h2{ 
      color: #FA8925;
    }
    a { 
      text-decoration: none;
      color: #FA8925;
      padding-left: 25px;
    }
    .button-container { 
      display: flex;
      align-items: center;
      justify-content: center;
     
    }
    .close { 
      color: #FA8925;
      text-decoration: none;
      background-color: #36454F;
      border: none;
      padding-left: 35px;
    }
  `

  const service1fetch = async () => { 
      const data = await fetch("/service1/api/data")
      console.log(data)
      const response = await data.json();
      console.log(response.msg)
      setService1(response.msg)
  }

  const service2fetch = async () => { 
    const data = await fetch("/service2/api/data")
    console.log(data)
    const response = await data.json()
    setService2(response.msg)
  }

  const closeService1 = async () => { 
    setService1('')
  }

  const closeService2 = async () => { 
    setService2('')
  }

  return (
    <Wrapper> 
      <div className="flex-container">
        <div className="flex-item">
          <h1>Sample App</h1>
          <h3>react / node apps running in EKS. testing</h3>
        </div>
        <button className='trigger' onClick={()=> service1fetch()}>Service 1</button>
        <button className='trigger' onClick={()=> service2fetch()}>Service 2</button>
      </div>
      <div className='show-service1'>
          {
            service1 ? <div className='button-container'><h2>{service1}</h2><button className='close' onClick={()=>closeService1()}><AiFillCloseCircle /></button></div> : null  
          }
      </div>
      <div className='show-service2'>
        {
          service2 ? <div className='button-container'><h2>{service2}</h2><button className='close' onClick={()=>closeService2()}><AiFillCloseCircle /></button></div> : null  
        }
      </div>
    </Wrapper>
  )
}

export default App;
