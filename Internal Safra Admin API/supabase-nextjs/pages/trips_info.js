import { useState, useEffect } from 'react'
import { useUser, useSupabaseClient } from '@supabase/auth-helpers-react'
import grid from '../styles/Home.module.css'
import Nav from '../components/Navbar'
import React from 'react'


export default function Participate({ Participate }) {
  const supabase = useSupabaseClient()
  const [_document, set_document] = React.useState(null)
  const [ctripid, settripidforc] = useState('')
  const [ctripname, settripnameforc] = useState('')
  const [cuid, setuidforc] = useState('')
  const [cactive, setactiveforc] = useState('')
  const [ccountry, setcourntyforc] = useState('')
  const [cfrom, setfromforc] = useState('')
  const [cto, settoforc] = useState('')
  const [cphotourl, setphotourlforc] = useState('')
  const [utripid, settripidforu] = useState('')
  const [utripname, settripnameforu] = useState('')
  const [uactive, setactiveforu] = useState('')
  const [ucountry, setcourntyforu] = useState('')
  const [ufrom, setfromforu] = useState('')
  const [uto, settoforu] = useState('')
  const [uphotourl, setphotourlforu] = useState('')
  const [dtripid, settripidford] = useState('')
 
  const [formError, set_FormError] = useState(null)
    
 
  const sendRecord = async (e) =>{
    e.preventDefault()

    if(!ctripid || !ctripname || !cuid || !cactive || !ccountry || !cfrom || !cto || cphotourl){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('trips_info').insert([{trip_id:ctripid, trip_name:ctripname, uid:cuid, active:cactive, country:ccountry, from: cfrom, to:cto, photo_url: cphotourl}]).select('*')

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

    if(!utripid || !utripname || !uactive || !ucountry || !ufrom || !uto || uphotourl){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('trips_info').update([{trip_id:utripid, trip_name:utripname, active:uactive, country:ucountry, from: ufrom, to:uto, photo_url:uphotourl}]).select('*')
    .eq('trip_id', utripid)
    .select('*')
    const { data1, error1} = await supabase.from('activities').update([{trip_name:utripname}]).select('*')
    .eq('trip_id', utripid)
    .select('*')
    const { data2, error2} = await supabase.from('participate').update([{active:uactive}]).select('*')
    .eq('trip_id', utripid)
    .select('*')

    if(error || error1 || error2){
      console.log(error)
      set_FormError("Invalid Input")
    }
    if(data || data1 || data2){
      console.log(data)
      set_FormError(null)
    }

  }

  const deleteRecord = async (e) =>{
    e.preventDefault()

    if(!dtripid){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('trips_info').delete().eq('trip_id',dtripid).select('*')

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
        .from('trips_info')
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
            <td>${data[i].trip_id}</td>
                    <td>${data[i].trip_name}</td>
                    <td>${data[i].uid}</td>
                    <td>${data[i].active}</td>
                    <td>${data[i].country}</td>
                    <td>${data[i].from}</td>
                    <td>${data[i].to}</td>
                    <td>${data[i].photo_url}</td>



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
            <label>trip_id</label>
            <input
            type="text"
            id="title"
            value={ctripid}
            onChange={(e)=> settripidforc(e.target.value)}/>

            <label>trip_name</label>
            <input
            type="text"
            id="title"
            value={ctripname}
            onChange={(e)=> settripnameforc(e.target.value)}/>

            <label>uid</label>
            <input
            type="text"
            id="title"
            value={cuid}
            onChange={(e)=> setuidforc(e.target.value)}/>

            <label>active</label>
            <input
            type="text"
            id="title"
            value={cactive}
            onChange={(e)=> setactiveforc(e.target.value)}/>

            <label>country</label>
            <input
            type="text"
            id="title"
            value={ccountry}
            onChange={(e)=> setcourntyforc(e.target.value)}/>

            <label>from</label>
            <input
            type="text"
            id="title"
            value={cfrom}
            onChange={(e)=> setfromforc(e.target.value)}/>

            <label>to</label>
            <input
            type="text"
            id="title"
            value={cto}
            onChange={(e)=> settoforc(e.target.value)}/>

            <label>photo_url</label>
            <input
            type="text"
            id="title"
            value={cphotourl}
            onChange={(e)=> setphotourlforc(e.target.value)}/>
            
            <button id='sendRecord'>Insert New Record</button>
            </form>

            <form className={grid.form} onSubmit={updateRecord}>
            <label>trip_id</label>
            <input
            type="text"
            id="title"
            value={utripid}
            onChange={(e)=> settripidforu(e.target.value)}/>

            <label>trip_name</label>
            <input
            type="text"
            id="title"
            value={utripname}
            onChange={(e)=> settripnameforu(e.target.value)}/>

            <label>active</label>
            <input
            type="text"
            id="title"
            value={uactive}
            onChange={(e)=> setactiveforu(e.target.value)}/>

            <label>country</label>
            <input
            type="text"
            id="title"
            value={ucountry}
            onChange={(e)=> setcourntyforu(e.target.value)}/>

            <label>from</label>
            <input
            type="text"
            id="title"
            value={ufrom}
            onChange={(e)=> setfromforu(e.target.value)}/>

            <label>to</label>
            <input
            type="text"
            id="title"
            value={uto}
            onChange={(e)=> settoforu(e.target.value)}/>

            <label>photo_url</label>
            <input
            type="text"
            id="title"
            value={uphotourl}
            onChange={(e)=> setphotourlforu(e.target.value)}/>
            
            <button id='sendRecord'>update record</button>
            </form>

        <form className={grid.form} onSubmit={deleteRecord}>
            <label>trip_id</label>
            <input
            type="text"
            id="title"
            value={dtripid}
            onChange={(e)=> settripidford(e.target.value)}/>

            
           
            <button id='sendRecord'>Delete Record</button>
            
            

            {formError && <p className='error'>{formError}</p>}
        </form>

            {formError && <p className='error'>{formError}</p>}
        </div>
    <table class={grid.table}>
      
      <thead>
      <tr >
        <th>trip_id</th>
        <th>trip_name</th>
        <th>uid</th>
        <th>active</th>
        <th>country</th>
        <th>from</th>
        <th>to</th>
        <th>photo_url</th>



       

      </tr>
      </thead>
      <tbody id='myTable'>
        
      </tbody>
      
      </table>  
      
   
    </>
  )
}