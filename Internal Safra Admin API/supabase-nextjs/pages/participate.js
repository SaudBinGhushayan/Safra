import { useState, useEffect } from 'react'
import { useUser, useSupabaseClient } from '@supabase/auth-helpers-react'
import grid from '../styles/Home.module.css'
import Nav from '../components/Navbar'
import React from 'react'


export default function Participate({ Participate }) {
  const supabase = useSupabaseClient()
  const [_document, set_document] = React.useState(null)
  const [Cparticipate_id, set_participate_idForC] = useState('')
  const [Ctrip_id, set_Trip_id_ForC] = useState('')
  const [Cuid, set_UIDForC] = useState('')
  const [Cusername, set_UsernameForC] = useState('')
  const [Cactive, set_ActiveForC] = useState('')
  const [Uparticipate_id, set_participate_idForU] = useState('')
  const [Utrip_id, set_Trip_id_ForU] = useState('')
  const [Uuid, set_UIDForU] = useState('')
  const [Uusername, set_UsernameForU] = useState('')
  const [Uactive, set_ActiveForU] = useState('')
  const [Dparticipate_id, set_participate_idForD] = useState('')
  const [Dusername, set_Username_ForD] = useState('')
 
  const [formError, set_FormError] = useState(null)
    
 
  const sendRecord = async (e) =>{
    e.preventDefault()

    if(!Cparticipate_id || !Ctrip_id || !Cuid || !Cusername || !Cactive){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('participate').insert([{participate_id:Cparticipate_id, trip_id:Ctrip_id, uid:Cuid, username:Cusername, active:Cactive}]).select('*')

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

    if(!Uparticipate_id || !Utrip_id || !Uuid || !Uusername || !Uactive){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('participate').update([{participate_id:Uparticipate_id, trip_id:Utrip_id, uid:Uuid, username:Uusername, active:Uactive}]).select('*')
    .eq('participate_id', Uparticipate_id)
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

    if(!Dparticipate_id || !Dusername){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('participate').delete().eq('participate_id',Dparticipate_id).eq('username',Dusername).select('*')

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
            value={Cparticipate_id}
            onChange={(e)=> set_participate_idForC(e.target.value)}/>

            <label>trip_id</label>
            <input
            type="text"
            id="title"
            value={Ctrip_id}
            onChange={(e)=> set_Trip_id_ForC(e.target.value)}/>

            <label>uid</label>
            <input
            type="text"
            id="title"
            value={Cuid}
            onChange={(e)=> set_UIDForC(e.target.value)}/>

            <label>username</label>
            <input
            type="text"
            id="title"
            value={Cusername}
            onChange={(e)=> set_UsernameForC(e.target.value)}/>

            <label>active</label>
            <input
            type="text"
            id="title"
            value={Cactive}
            onChange={(e)=> set_ActiveForC(e.target.value)}/>
            <button id='sendRecord'>Insert New Record</button>
            {formError && <p className='error'>{formError}</p>}

            </form>

            <form className={grid.form} onSubmit={updateRecord}>
            <label>participate_id</label>
            <input
            type="text"
            id="title"
            value={Uparticipate_id}
            onChange={(e)=> set_participate_idForU(e.target.value)}/>

            <label>trip_id</label>
            <input
            type="text"
            id="title"
            value={Utrip_id}
            onChange={(e)=> set_Trip_id_ForU(e.target.value)}/>

            <label>uid</label>
            <input
            type="text"
            id="title"
            value={Uuid}
            onChange={(e)=> set_UIDForU(e.target.value)}/>

            <label>username</label>
            <input
            type="text"
            id="title"
            value={Uusername}
            onChange={(e)=> set_UsernameForU(e.target.value)}/>

            <label>active</label>
            <input
            type="text"
            id="title"
            value={Uactive}
            onChange={(e)=> set_ActiveForU(e.target.value)}/>
            <button id='sendRecord'>update record</button>
            
            

            {formError && <p className='error'>{formError}</p>}
        </form>

        <form className={grid.form} onSubmit={deleteRecord}>
            <label>participate_id</label>
            <input
            type="text"
            id="title"
            value={Dparticipate_id}
            onChange={(e)=> set_participate_idForD(e.target.value)}/>

            <label>username</label>
            <input
            type="text"
            id="title"
            value={Dusername}
            onChange={(e)=> set_Username_ForD(e.target.value)}/>
           
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