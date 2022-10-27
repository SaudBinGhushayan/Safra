import { useState, useEffect } from 'react'
import { useUser, useSupabaseClient } from '@supabase/auth-helpers-react'
import grid from '../styles/Home.module.css'
import Nav from '../components/Navbar'
import React from 'react'


export default function Trips_Comments({ Trips_Comments }) {
  const supabase = useSupabaseClient()
  const [_document, set_document] = React.useState(null)
  var index = 0;
  
  useEffect(() => {
    getParticipate(), set_document(document)
  }, [Trips_Comments])

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
    
    <Nav />
      
    <table class={grid.table}>
      
      <thead>
      <tr>
        <th>trip_comment_id</th>
        <th>trip_id</th>
        <th>comment</th>
        <th>likes</th>
        <th>dislikes</th>
        <th>username</th>

      </tr>
      </thead>
      <tbody class={grid.tableTHTD} id='myTable'>
         
      </tbody>
      
      </table>   
           
        

   
    </>
  )
}