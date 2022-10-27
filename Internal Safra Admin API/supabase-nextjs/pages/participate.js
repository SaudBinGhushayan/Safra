import { useState, useEffect } from 'react'
import { useUser, useSupabaseClient } from '@supabase/auth-helpers-react'
import grid from '../styles/Home.module.css'
import Nav from '../components/Navbar'
import React from 'react'


export default function Participate({ Participate }) {
  const supabase = useSupabaseClient()
  const [_document, set_document] = React.useState(null)
  const [participate_id, set_participate_id] = useState('')
  const [trip_id, set_Trip_id] = useState('')
  const [uid, set_UID] = useState('')
  const [username, set_Username] = useState('')
  const [active, set_Active] = useState('')
  
  const [formError, set_FormError] = useState(null)


  const sendRecord = async (e) =>{
    e.preventDefault()

    if(!participate_id || !trip_id || !uid || !username || !active){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('participate').insert([{participate_id, trip_id, uid, username, active}]).select('*')

    if(error){
      console.log(error)
      set_FormError("Invalid Input")
    }
    if(data){
      console.log(data)
      set_FormError(null)
    }

  }

  const updateRecord = async (e) =>{
    e.preventDefault()

    if(!participate_id || !trip_id || !uid || !username || !active){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('participate').update({ participate_id, trip_id, uid, username, active })
    .eq('participate_id', participate_id)
    .select('*')

    if(error){
      console.log(error)
      set_FormError("Invalid Input")
    }
    if(data){
      console.log(data)
      set_FormError(null)
    }

  }

  const deleteRecord = async (e) =>{
    e.preventDefault()

    if(!participate_id || !username){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('participate').delete().eq('participate_id',participate_id).eq('username',username).select('*')

    if(error){
      console.log(error)
      set_FormError("Invalid Input")
    }
    if(data){
      console.log(data)
      set_FormError(null)
    }

  }
  var index = 0;
  
  useEffect(() => {
    getParticipate(), set_document(document)
  }, [Participate])

  async function getParticipate() {
    try {

      let { data, error, status } = await supabase
        .from('participate')
        .select('*')
        console.log(data)
        

      if (error && status !== 406) {
        throw error
      }

      if (data && index == 0) {
        index = 1
        var table = document.getElementById('myTable')
      
        for (var i = 0 ; i < data.length; i++){
          var row =  `<tr>
            <td>${data[i].participate_id}</td>
                    <td>${data[i].trip_id}</td>
                    <td>${data[i].uid}</td>
                    <td>${data[i].username}</td>
                    <td>${data[i].active}</td>
          </tr>`
          table.innerHTML += row
        }
        
        
      }
    } catch (error) {
      alert('Error loading data!')
      console.log(error)
    } 
  }

  

  
  return (
    <>
    <div className={grid.formWrapper}>
        <img class={grid.image} src="/Safra Logo.jpeg" />

    <Nav />
    </div>
    <div className={grid.formWrapper}>
           <form className={grid.form} onSubmit={sendRecord}>
            <label>participate_id</label>
            <input
            type="text"
            id="title"
            value={participate_id}
            onChange={(e)=> set_participate_id(e.target.value)}/>

            <label>trip_id</label>
            <input
            type="text"
            id="title"
            value={trip_id}
            onChange={(e)=> set_Trip_id(e.target.value)}/>

            <label>uid</label>
            <input
            type="text"
            id="title"
            value={uid}
            onChange={(e)=> set_UID(e.target.value)}/>

            <label>username</label>
            <input
            type="text"
            id="title"
            value={username}
            onChange={(e)=> set_Username(e.target.value)}/>

            <label>active</label>
            <input
            type="text"
            id="title"
            value={active}
            onChange={(e)=> set_Active(e.target.value)}/>
            <button id='sendRecord'>Insert New Record</button>
            </form>
            <form className={grid.form} onSubmit={updateRecord}>
            <label>participate_id</label>
            <input
            type="text"
            id="title"
            value={participate_id}
            onChange={(e)=> set_participate_id(e.target.value)}/>

            <label>trip_id</label>
            <input
            type="text"
            id="title"
            value={trip_id}
            onChange={(e)=> set_Trip_id(e.target.value)}/>

            <label>uid</label>
            <input
            type="text"
            id="title"
            value={uid}
            onChange={(e)=> set_UID(e.target.value)}/>

            <label>username</label>
            <input
            type="text"
            id="title"
            value={username}
            onChange={(e)=> set_Username(e.target.value)}/>

            <label>active</label>
            <input
            type="text"
            id="title"
            value={active}
            onChange={(e)=> set_Active(e.target.value)}/>
            <button id='sendRecord'>update record</button>
            
            

            {formError && <p className='error'>{formError}</p>}
        </form>

        <form className={grid.form} onSubmit={deleteRecord}>
            <label>participate_id</label>
            <input
            type="text"
            id="title"
            value={participate_id}
            onChange={(e)=> set_participate_id(e.target.value)}/>

            <label>username</label>
            <input
            type="text"
            id="title"
            value={username}
            onChange={(e)=> set_Username(e.target.value)}/>
           
            <button id='sendRecord'>Delete Record</button>
            
            

            {formError && <p className='error'>{formError}</p>}
        </form>

            {formError && <p className='error'>{formError}</p>}
        </div>
    <table class={grid.table}>
      
      <thead>
      <tr >
        <th>participate_id</th>
        <th>trip_id</th>
        <th>uid</th>
        <th>username</th>
        <th>active</th>
       

      </tr>
      </thead>
      <tbody id='myTable'>
        
      </tbody>
      
      </table>  
      
   
    </>
  )
}