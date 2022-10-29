import { useState, useEffect } from 'react'
import { useUser, useSupabaseClient } from '@supabase/auth-helpers-react'
import grid from '../styles/Home.module.css'
import Nav from '../components/Navbar'
import React from 'react'


export default function Participate({ Participate }) {
  const supabase = useSupabaseClient()
  const [_document, set_document] = React.useState(null)
  const [clikeid, setlikeidforc] = useState('')
  const [ctripid, settripidforc] = useState('')
  const [clike, setlikeforc] = useState('')
  const [cuid, setuidforc] = useState('')
  const [ulikeid, setlikeidforu] = useState('')
  const [utripid, settripidforu] = useState('')
  const [ulike, setlikeforu] = useState('')
  const [uuid, setuidforu] = useState('')
  const [dlikeid, setlikeidford] = useState('')
  const [formError, set_FormError] = useState(null)
    
 
  const sendRecord = async (e) =>{
    e.preventDefault()

    if(!clikeid || !ctripid || !clike || !cuid ){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('trips_likes').insert([{like_id:clikeid, trip_id:ctripid, like:clike, uid: cuid}]).select('*')

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

    if(!ulikeid || !utripid || !ulike || !uuid ){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('trips_likes').update([{like_id:ulikeid, trip_id:utripid, like:ulike, uid: uuid}]).select('*')
    .eq('like_id', ulikeid)
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

    if(!dlikeid){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('trips_likes').delete().eq('like_id',dlikeid).select('*')

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
        .from('trips_likes')
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
            <td>${data[i].like_id}</td>
                    <td>${data[i].trip_id}</td>
                    <td>${data[i].like}</td>
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
            <label>like_id</label>
            <input
            type="text"
            id="title"
            value={clikeid}
            onChange={(e)=> setlikeidforc(e.target.value)}/>

            <label>trip_id</label>
            <input
            type="text"
            id="title"
            value={ctripid}
            onChange={(e)=> settripidforc(e.target.value)}/>

            <label>like</label>
            <input
            type="text"
            id="title"
            value={clike}
            onChange={(e)=> setlikeforc(e.target.value)}/>

            <label>uid</label>
            <input
            type="text"
            id="title"
            value={cuid}
            onChange={(e)=> setuidforc(e.target.value)}/>

            <button id='sendRecord'>Insert New Record</button>
            </form>

            <form className={grid.form} onSubmit={updateRecord}>
            <label>like_id</label>
            <input
            type="text"
            id="title"
            value={ulikeid}
            onChange={(e)=> setlikeidforu(e.target.value)}/>

            <label>trip_id</label>
            <input
            type="text"
            id="title"
            value={utripid}
            onChange={(e)=> settripidforu(e.target.value)}/>

            <label>like</label>
            <input
            type="text"
            id="title"
            value={ulike}
            onChange={(e)=> setlikeforu(e.target.value)}/>

            <label>uid</label>
            <input
            type="text"
            id="title"
            value={uuid}
            onChange={(e)=> setuidforu(e.target.value)}/>

            <button id='sendRecord'>update record</button>
            </form>

        <form className={grid.form} onSubmit={deleteRecord}>
            <label>like_id</label>
            <input
            type="text"
            id="title"
            value={dlikeid}
            onChange={(e)=> setlikeidford(e.target.value)}/>

            
           
            <button id='sendRecord'>Delete Record</button>
            
            

            {formError && <p className='error'>{formError}</p>}
        </form>

            {formError && <p className='error'>{formError}</p>}
        </div>
    <table class={grid.table}>
      
      <thead>
      <tr >
        <th>like_id</th>
        <th>trip_id</th>
        <th>like</th>
        <th>uid</th>
      
      </tr>
      </thead>
      <tbody id='myTable'>
        
      </tbody>
      
      </table>  
      
   
    </>
  )
}