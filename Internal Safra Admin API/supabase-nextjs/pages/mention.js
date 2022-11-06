import { useState, useEffect } from 'react'
import { useUser, useSupabaseClient } from '@supabase/auth-helpers-react'
import grid from '../styles/Home.module.css'
import Nav from '../components/Navbar'
import React from 'react'


export default function Participate({ Participate }) {
  const supabase = useSupabaseClient()
  const [_document, set_document] = React.useState(null)
  const [cmentionid, setcmentionidforc] = useState('')
  const [ctripid, settripidforc] = useState('')
  const [ctripname, settripnameforc] = useState('')
  const [csusername, setsusernameforc] = useState('')
  const [cmessage, setmessageforc] = useState('')
  const [cuid, setuidforc] = useState('')
  const [umentionid, setcmentionidforu] = useState('')
  const [utripid, settripidforu] = useState('')
  const [utripname, settripnameforu] = useState('')
  const [ususername, setsusernameforu] = useState('')
  const [umessage, setmessageforu] = useState('')
  const [uuid, setuidforu] = useState('')
  const [dmentionid, setmentionidford] = useState('')
 
  const [formError, set_FormError] = useState(null)
    
 
  const sendRecord = async (e) =>{
    e.preventDefault()

    if(!cmentionid || !ctripid || !ctripname || !csusername || !cmessage || !cuid){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('mention').insert([{mention_id:cmentionid, trip_id:ctripid, trip_name:ctripname, susername:csusername, message:cmessage, uid: cuid}]).select('*')

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

    if(!umentionid || !utripid || !utripname || !ususername || !umessage || !uuid){
        set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('mention').update([{mention_id:umentionid, trip_id:utripid, trip_name:utripname, susername:ususername, message:umessage, uid: uuid}]).eq('mention_id', umentionid).select('*')


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

    if(!dmentionid){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('mention').delete().eq('mention_id',dmentionid).select('*')

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
        .from('mention')
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
            <td>${data[i].mention_id}</td>
                    <td>${data[i].trip_id}</td>
                    <td>${data[i].trip_name}</td>
                    <td>${data[i].susername}</td>
                    <td>${data[i].message}</td>
                    <td>${data[i].uid}</td>

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
            <label>Mention_id</label>
            <input
            type="text"
            id="title"
            value={cmentionid}
            onChange={(e)=> setcmentionidforc(e.target.value)}/>

            <label>Trip_id</label>
            <input
            type="text"
            id="title"
            value={ctripid}
            onChange={(e)=> settripidforc(e.target.value)}/>

            <label>Trip_name</label>
            <input
            type="text"
            id="title"
            value={ctripname}
            onChange={(e)=> settripnameforc(e.target.value)}/>

            <label>Susername</label>
            <input
            type="text"
            id="title"
            value={csusername}
            onChange={(e)=> setsusernameforc(e.target.value)}/>

            <label>Message</label>
            <input
            type="text"
            id="title"
            value={cmessage}
            onChange={(e)=> setmessageforc(e.target.value)}/>

            <label>Uid</label>
            <input
            type="text"
            id="title"
            value={cuid}
            onChange={(e)=> setuidforc(e.target.value)}/>
            
            <button id='sendRecord'>Insert New Record</button>
            </form>

            <form className={grid.form} onSubmit={updateRecord}>
            <label>Mention_id</label>
            <input
            type="text"
            id="title"
            value={umentionid}
            onChange={(e)=> setcmentionidforu(e.target.value)}/>

            <label>Trip_id</label>
            <input
            type="text"
            id="title"
            value={utripid}
            onChange={(e)=> settripidforu(e.target.value)}/>

            <label>Trip_name</label>
            <input
            type="text"
            id="title"
            value={utripname}
            onChange={(e)=> settripnameforu(e.target.value)}/>

            <label>Susername</label>
            <input
            type="text"
            id="title"
            value={ususername}
            onChange={(e)=> setsusernameforu(e.target.value)}/>

            <label>Message</label>
            <input
            type="text"
            id="title"
            value={umessage}
            onChange={(e)=> setmessageforu(e.target.value)}/>

            <label>Uid</label>
            <input
            type="text"
            id="title"
            value={uuid}
            onChange={(e)=> setuidforu(e.target.value)}/>
            
            <button id='sendRecord'>update Record</button>
            </form>

        <form className={grid.form} onSubmit={deleteRecord}>
            <label>Mention_id</label>
            <input
            type="text"
            id="title"
            value={dmentionid}
            onChange={(e)=> setmentionidford(e.target.value)}/>

            
           
            <button id='sendRecord'>Delete Record</button>
            
            

            {formError && <p className='error'>{formError}</p>}
        </form>

            {formError && <p className='error'>{formError}</p>}
        </div>
    <table class={grid.table}>
      
      <thead>
      <tr >
        <th>Mention_id</th>
        <th>Trip_id</th>
        <th>Trip_name</th>
        <th>Susername</th>
        <th>Message</th>
        <th>Uid</th>

       

      </tr>
      </thead>
      <tbody id='myTable'>
        
      </tbody>
      
      </table>  
      
   
    </>
  )
}