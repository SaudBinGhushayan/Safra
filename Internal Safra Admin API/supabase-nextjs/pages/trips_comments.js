import { useState, useEffect } from 'react'
import { useUser, useSupabaseClient } from '@supabase/auth-helpers-react'
import grid from '../styles/Home.module.css'
import Nav from '../components/Navbar'
import React from 'react'


export default function Participate({ Participate }) {
  const supabase = useSupabaseClient()
  const [_document, set_document] = React.useState(null)
  const [ctripcommentid, settripcommentidforc] = useState('')
  const [ctripid, settripidforc] = useState('')
  const [ccomment, setcommentsforc] = useState('')
  const [clikes, setlikesforc] = useState('')
  const [cdislikes, setdislikesforc] = useState('')
  const [cusername, setusernameforc] = useState('')
  const [utripcommentid, settripcommentidforu] = useState('')
  const [utripid, settripidforu] = useState('')
  const [ucomment, setcommentsforu] = useState('')
  const [ulikes, setlikesforu] = useState('')
  const [udislikes, setdislikesforu] = useState('')
  const [uusername, setusernameforu] = useState('')
  const [dtripcommentid, settripcommentidford] = useState('')
 
  const [formError, set_FormError] = useState(null)
    
 
  const sendRecord = async (e) =>{
    e.preventDefault()

    if(!ctripcommentid || !ctripid || !ccomment || !clikes || !cdislikes || !cusername){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('trip_comments').insert([{trip_comment_id:ctripcommentid, trip_id:ctripid, comment:ccomment, likes: clikes, dislikes:cdislikes, username:cusername}]).select('*')

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

    if(!utripcommentid || !utripid || !ucomment || !ulikes || !udislikes || !uusername){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('trip_comments').update([{trip_comment_id:utripcommentid, trip_id:utripid, comment:ucomment, likes: ulikes, dislikes:udislikes, username:uusername}]).select('*')
    .eq('trip_comment_id', utripcommentid)
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

    if(!dtripcommentid){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('trip_comments').delete().eq('trip_comment_id',dtripcommentid).select('*')

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
        .from('trip_comments')
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
            <td>${data[i].trip_comment_id}</td>
                    <td>${data[i].trip_id}</td>
                    <td>${data[i].comment}</td>
                    <td>${data[i].likes}</td>
                    <td>${data[i].dislikes}</td>
                    <td>${data[i].username}</td>
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
            <label>trip_comment_id</label>
            <input
            type="text"
            id="title"
            value={ctripcommentid}
            onChange={(e)=> settripcommentidforc(e.target.value)}/>

            <label>trip_id</label>
            <input
            type="text"
            id="title"
            value={ctripid}
            onChange={(e)=> settripidforc(e.target.value)}/>

            <label>comment</label>
            <input
            type="text"
            id="title"
            value={ccomment}
            onChange={(e)=> setcommentsforc(e.target.value)}/>

            <label>likes</label>
            <input
            type="text"
            id="title"
            value={clikes}
            onChange={(e)=> setlikesforc(e.target.value)}/>

            <label>dislikes</label>
            <input
            type="text"
            id="title"
            value={cdislikes}
            onChange={(e)=> setdislikesforc(e.target.value)}/>

            <label>username</label>
            <input
            type="text"
            id="title"
            value={cusername}
            onChange={(e)=> setusernameforc(e.target.value)}/>
            
            <button id='sendRecord'>Insert New Record</button>
            </form>

            <form className={grid.form} onSubmit={updateRecord}>
            <label>trip_comment_id</label>
            <input
            type="text"
            id="title"
            value={utripcommentid}
            onChange={(e)=> settripcommentidforu(e.target.value)}/>

            <label>trip_id</label>
            <input
            type="text"
            id="title"
            value={utripid}
            onChange={(e)=> settripidforu(e.target.value)}/>

            <label>comment</label>
            <input
            type="text"
            id="title"
            value={ucomment}
            onChange={(e)=> setcommentsforu(e.target.value)}/>

            <label>likes</label>
            <input
            type="text"
            id="title"
            value={ulikes}
            onChange={(e)=> setlikesforu(e.target.value)}/>

            <label>dislikes</label>
            <input
            type="text"
            id="title"
            value={udislikes}
            onChange={(e)=> setdislikesforu(e.target.value)}/>

            <label>username</label>
            <input
            type="text"
            id="title"
            value={uusername}
            onChange={(e)=> setusernameforu(e.target.value)}/>
            
            <button id='sendRecord'>update Record</button>
            </form>

        <form className={grid.form} onSubmit={deleteRecord}>
            <label>trip_comment_id</label>
            <input
            type="text"
            id="title"
            value={dtripcommentid}
            onChange={(e)=> settripcommentidford(e.target.value)}/>

            
           
            <button id='sendRecord'>Delete Record</button>
            
            

            {formError && <p className='error'>{formError}</p>}
        </form>

            {formError && <p className='error'>{formError}</p>}
        </div>
    <table class={grid.table}>
      
      <thead>
      <tr >
        <th>trip_comment_id</th>
        <th>trip_id</th>
        <th>comment</th>
        <th>likes</th>
        <th>dislikes</th>
        <th>username</th>


       

      </tr>
      </thead>
      <tbody id='myTable'>
        
      </tbody>
      
      </table>  
      
   
    </>
  )
}