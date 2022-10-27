import { useState, useEffect } from 'react'
import { useUser, useSupabaseClient } from '@supabase/auth-helpers-react'
import grid from '../styles/Home.module.css'
import Nav from '../components/Navbar'
import React from 'react'


export default function Trips_Info({ Trips_Info }) {
  const supabase = useSupabaseClient()
  const [_document, set_document] = React.useState(null)
  var index = 0;
  
  useEffect(() => {
    getParticipate(), set_document(document)
  }, [Trips_Info])

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
      
      <thead><tr>
        <th>trip_id</th>
        <th>trip_name</th>
        <th>uid</th>
        <th>active</th>
        <th>country</th>
        <th>from</th>
        <th>to</th>

      </tr></thead>
      <tbody id='myTable'>
         
      </tbody>
      
      </table>   
           
        

   
    </>
  )
}