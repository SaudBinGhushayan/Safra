import { useState, useEffect } from 'react'
import { useUser, useSupabaseClient } from '@supabase/auth-helpers-react'
import grid from '../styles/Home.module.css'
import Nav from '../components/Navbar'
import React from 'react'


export default function Participate({ Participate }) {
  const supabase = useSupabaseClient()
  const [_document, set_document] = React.useState(null)
  const [ccommentid, setcommentidforc] = useState('')
  const [cuid, setuidforc] = useState('')
  const [cfsq_id, setfsqidforc] = useState('')
  const [ccomment, setcommentforc] = useState('')
  const [clikes, setlikesforc] = useState('')
  const [cdislikes, setdislikesforc] = useState('')
  const [ucommentid, setcommentidforu] = useState('')
  const [uuid, setuidforu] = useState('')
  const [ufsq_id, setfsqidforu] = useState('')
  const [ucomment, setcommentforu] = useState('')
  const [ulikes, setlikesforu] = useState('')
  const [udislikes, setdislikesforu] = useState('')
  const [dcommentid, setcommentidford] = useState('')
 
  const [formError, set_FormError] = useState(null)
    
 
  const sendRecord = async (e) =>{
    e.preventDefault()

    if(!ccommentid || !cuid || !cfsq_id || !ccomment || !clikes || !cdislikes){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('comments').insert([{comment_id:ccommentid, uid:cuid, fsq_id:cfsq_id, comment:ccomment, likes:clikes, dislikes: cdislikes}]).select('*')

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

    if(!ucommentid || !uuid || !ufsq_id || !ucomment || !ulikes || !udislikes){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('comments').update([{comment_id:ucommentid, uid:uuid, fsq_id:ufsq_id, comment:ucomment, likes:ulikes, dislikes: udislikes}]).select('*')
    .eq('comment_id', ucommentid)
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

    if(!dcommentid){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('comments').delete().eq('comment_id',dcommentid).select('*')

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
        .from('comments')
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
            <td>${data[i].comment_id}</td>
                    <td>${data[i].uid}</td>
                    <td>${data[i].fsq_id}</td>
                    <td>${data[i].comment}</td>
                    <td>${data[i].likes}</td>
                    <td>${data[i].dislikes}</td>

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
            <label>comment_id</label>
            <input
            type="text"
            id="title"
            value={ccommentid}
            onChange={(e)=> setcommentidforc(e.target.value)}/>

            <label>uid</label>
            <input
            type="text"
            id="title"
            value={cuid}
            onChange={(e)=> setuidforc(e.target.value)}/>

            <label>fsq_id</label>
            <input
            type="text"
            id="title"
            value={cfsq_id}
            onChange={(e)=> setfsqidforc(e.target.value)}/>

            <label>comment</label>
            <input
            type="text"
            id="title"
            value={ccomment}
            onChange={(e)=> setcommentforc(e.target.value)}/>

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
            
            <button id='sendRecord'>Insert New Record</button>
            </form>

            <form className={grid.form} onSubmit={updateRecord}>
            <label>comment_id</label>
            <input
            type="text"
            id="title"
            value={ucommentid}
            onChange={(e)=> setcommentidforu(e.target.value)}/>

            <label>uid</label>
            <input
            type="text"
            id="title"
            value={uuid}
            onChange={(e)=> setuidforu(e.target.value)}/>

            <label>fsq_id</label>
            <input
            type="text"
            id="title"
            value={ufsq_id}
            onChange={(e)=> setfsqidforu(e.target.value)}/>

            <label>comment</label>
            <input
            type="text"
            id="title"
            value={ucomment}
            onChange={(e)=> setcommentforu(e.target.value)}/>

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
            <button id='sendRecord'>update record</button>
            </form>

        <form className={grid.form} onSubmit={deleteRecord}>
            <label>comment_id</label>
            <input
            type="text"
            id="title"
            value={dcommentid}
            onChange={(e)=> setcommentidford(e.target.value)}/>

            
           
            <button id='sendRecord'>Delete Record</button>
            
            

            {formError && <p className='error'>{formError}</p>}
        </form>

            {formError && <p className='error'>{formError}</p>}
        </div>
    <table class={grid.table}>
      
      <thead>
      <tr >
        <th>comment_id</th>
        <th>uid</th>
        <th>fsq_id</th>
        <th>comment</th>
        <th>likes</th>
        <th>dislikes</th>

       

      </tr>
      </thead>
      <tbody id='myTable'>
        
      </tbody>
      
      </table>  
      
   
    </>
  )
}