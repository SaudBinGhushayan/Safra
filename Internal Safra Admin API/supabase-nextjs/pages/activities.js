import { useState, useEffect } from 'react'
import { useUser, useSupabaseClient } from '@supabase/auth-helpers-react'
import grid from '../styles/Home.module.css'
import Nav from '../components/Navbar'
import React from 'react'


export default function Participate({ Participate }) {
  const supabase = useSupabaseClient()
  const [_document, set_document] = React.useState(null)
  const [Ctrip_id, set_Trip_id_ForC] = useState('')
  const [Cfsq_id, setfsqidforc] = useState('')
  const [Cname, setnameforc] = useState('')
  const [Cuid, setuidforc] = useState('')
  const [Crating, setratingforc] = useState('')
  const [Ctel, settelforc] = useState('')
  const [Ccountry, setcountryforc] = useState('')
  const [Cregion, setregionforc] = useState('')
  const [Cprice, setpriceforc] = useState('')
  const [Cdescription, setdescriptionforc] = useState('')
  const [Ctripname, settripnameforc] = useState('')
  const [Ctranslateddescription, settranslateddescriptionforc] = useState('')
  const [Ccategories, setcategoriesforc] = useState('')
  const [Cphotourl, setphotourlforc] = useState('')
  const [Utrip_id, set_Trip_id_Foru] = useState('')
  const [Ufsq_id, setfsqidforu] = useState('')
  const [Uname, setnameforu] = useState('')
  const [Uuid, setuidforu] = useState('')
  const [Urating, setratingforcu] = useState('')
  const [Utel, settelforu] = useState('')
  const [Ucountry, setcountryforu] = useState('')
  const [Uregion, setregionforu] = useState('')
  const [Uprice, setpriceforu] = useState('')
  const [Udescription, setdescriptionforu] = useState('')
  const [Utripname, settripnameforu] = useState('')
  const [Utranslateddescription, settranslateddescriptionforu] = useState('')
  const [Ucategories, setcategoriesforu] = useState('')
  const [Uphotourl, setphotourlforu] = useState('')
  const [Dtrip_id, set_Trip_id_ForD] = useState('')
  const [Dfsq_id, setfsqidford] = useState('')
  

 
  const [formError, set_FormError] = useState(null)
    
 
  const sendRecord = async (e) =>{
    e.preventDefault()

    if(!Ctrip_id || !Cfsq_id || !Cname || !Cuid || !Crating || !Ctel || !Ccountry || !Cregion || !Cprice || !Cdescription || !Ctripname || !Ctranslateddescription || !Ccategories || !Cphotourl){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('activities').insert([{trip_id:Ctrip_id,
         fsq_id:Cfsq_id, name:Cname, uid:Cuid,
          rating:Crating, tel: Ctel, country: Ccountry,
           region: Cregion, price: Cprice, description:Cdescription,
            trip_name: Ctripname, translated_description: Ctranslateddescription,
             categories: Ccategories, photo_url: Cphotourl }]).select('*')

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

    if(!Utrip_id || !Ufsq_id || !Uname || !Uuid || !Urating || !Utel || !Ucountry || !Uregion || !Uprice || !Udescription || !Utripname || !Utranslateddescription || !Ucategories || !Uphotourl){
        set_FormError('Please fill in all fields correctly')
        return 
      }
      const { data, error} = await supabase.from('activities').update([{trip_id:Utrip_id,
           fsq_id:Ufsq_id, name:Uname, uid:Uuid,
            rating:Urating, tel: Utel, country: Ucountry,
             region: Uregion, price: Uprice, description:Udescription,
              trip_name: Utripname, translated_description: Utranslateddescription,
               categories: Ucategories, photo_url: Uphotourl }]).eq('trip_id', Utrip_id).eq('fsq_id',Ufsq_id).select('*')

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

    if(!Dtrip_id || !Dfsq_id){
      set_FormError('Please fill in all fields correctly')
      return 
    }
    const { data, error} = await supabase.from('activities').delete().eq('trip_id',Dtrip_id).eq('fsq_id',Dfsq_id).select('*')

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
        .from('activities')
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
                    <td>${data[i].fsq_id}</td>
                    <td>${data[i].name}</td>
                    <td>${data[i].uid}</td>
                    <td>${data[i].rating}</td>
                    <td>${data[i].tel}</td>
                    <td>${data[i].country}</td>
                    <td>${data[i].region}</td>
                    <td>${data[i].price}</td>
                    <td>${data[i].description}</td>
                    <td>${data[i].trip_name}</td>
                    <td>${data[i].translated_description}</td>
                    <td>${data[i].categories}</td>
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
            value={Ctrip_id}
            onChange={(e)=> set_Trip_id_ForC(e.target.value)}/>

            <label>fsq_id</label>
            <input
            type="text"
            id="title"
            value={Cfsq_id}
            onChange={(e)=> setfsqidforc(e.target.value)}/>

            <label>name</label>
            <input
            type="text"
            id="title"
            value={Cname}
            onChange={(e)=> setnameforc(e.target.value)}/>

            <label>uid</label>
            <input
            type="text"
            id="title"
            value={Cuid}
            onChange={(e)=> setuidforc(e.target.value)}/>

            <label>rating</label>
            <input
            type="text"
            id="title"
            value={Crating}
            onChange={(e)=> setratingforc(e.target.value)}/>
            
            <label>tel</label>
            <input
            type="text"
            id="title"
            value={Ctel}
            onChange={(e)=> settelforc(e.target.value)}/>

            <label>country</label>
            <input
            type="text"
            id="title"
            value={Ccountry}
            onChange={(e)=> setcountryforc(e.target.value)}/>

            <label>region</label>
            <input
            type="text"
            id="title"
            value={Cregion}
            onChange={(e)=> setregionforc(e.target.value)}/>

            <label>price</label>
            <input
            type="text"
            id="title"
            value={Cprice}
            onChange={(e)=> setpriceforc(e.target.value)}/>

            <label>description</label>
            <input
            type="text"
            id="title"
            value={Cdescription}
            onChange={(e)=> setdescriptionforc(e.target.value)}/>

            <label>trip_name</label>
            <input
            type="text"
            id="title"
            value={Ctripname}
            onChange={(e)=> settripnameforc(e.target.value)}/>

            <label>translated_description</label>
            <input
            type="text"
            id="title"
            value={Ctranslateddescription}
            onChange={(e)=> settranslateddescriptionforc(e.target.value)}/>

            <label>categories</label>
            <input
            type="text"
            id="title"
            value={Ccategories}
            onChange={(e)=> setcategoriesforc(e.target.value)}/>

            <label>photo_url</label>
            <input
            type="text"
            id="title"
            value={Cphotourl}
            onChange={(e)=> setphotourlforc(e.target.value)}/>

            <button id='sendRecord'>Insert New Record</button>
            {formError && <p className='error'>{formError}</p>}

            </form>
        
        <form className={grid.form} onSubmit={updateRecord}>
            <label>trip_id</label>
            <input
            type="text"
            id="title"
            value={Utrip_id}
            onChange={(e)=> set_Trip_id_Foru(e.target.value)}/>

            <label>fsq_id</label>
            <input
            type="text"
            id="title"
            value={Ufsq_id}
            onChange={(e)=> setfsqidforu(e.target.value)}/>

            <label>name</label>
            <input
            type="text"
            id="title"
            value={Uname}
            onChange={(e)=> setnameforu(e.target.value)}/>

            <label>uid</label>
            <input
            type="text"
            id="title"
            value={Uuid}
            onChange={(e)=> setuidforu(e.target.value)}/>

            <label>rating</label>
            <input
            type="text"
            id="title"
            value={Urating}
            onChange={(e)=> setratingforcu(e.target.value)}/>
            
            <label>tel</label>
            <input
            type="text"
            id="title"
            value={Utel}
            onChange={(e)=> settelforu(e.target.value)}/>

            <label>country</label>
            <input
            type="text"
            id="title"
            value={Ucountry}
            onChange={(e)=> setcountryforu(e.target.value)}/>

            <label>region</label>
            <input
            type="text"
            id="title"
            value={Uregion}
            onChange={(e)=> setregionforu(e.target.value)}/>

            <label>price</label>
            <input
            type="text"
            id="title"
            value={Uprice}
            onChange={(e)=> setpriceforu(e.target.value)}/>

            <label>description</label>
            <input
            type="text"
            id="title"
            value={Udescription}
            onChange={(e)=> setdescriptionforu(e.target.value)}/>

            <label>trip_name</label>
            <input
            type="text"
            id="title"
            value={Utripname}
            onChange={(e)=> settripnameforu(e.target.value)}/>

            <label>translated_description</label>
            <input
            type="text"
            id="title"
            value={Utranslateddescription}
            onChange={(e)=> settranslateddescriptionforu(e.target.value)}/>

            <label>categories</label>
            <input
            type="text"
            id="title"
            value={Ucategories}
            onChange={(e)=> setcategoriesforu(e.target.value)}/>

            <label>photo_url</label>
            <input
            type="text"
            id="title"
            value={Uphotourl}
            onChange={(e)=> setphotourlforu(e.target.value)}/>

            <button id='sendRecord'>Updated Record</button>

            {formError && <p className='error'>{formError}</p>}

            </form>


            <form className={grid.form} onSubmit={deleteRecord}>
            <label>trip_id</label>
            <input
            type="text"
            id="title"
            value={Dtrip_id}
            onChange={(e)=> set_Trip_id_ForD(e.target.value)}/>

            <label>fsq_id</label>
            <input
            type="text"
            id="title"
            value={Dfsq_id}
            onChange={(e)=> setfsqidford(e.target.value)}/>

            <button >Delete Record</button>
            {formError && <p className='error'>{formError}</p>}

            </form>

        </div>
    <table class={grid.table}>
      
      <thead>
      <tr >
        <th>trip_id</th>
        <th>fsq_id</th>
        <th>name</th>
        <th>uid</th>
        <th>rating</th>
        <th>tel</th>
        <th>country</th>
        <th>region</th>
        <th>price</th>
        <th>description</th>
        <th>trip_name</th>
        <th>translated_description</th>
        <th>categories</th>
        <th>photo_url</th>



       

      </tr>
      </thead>
      <tbody id='myTable'>
        
      </tbody>
      
      </table>  
      
   
    </>
  )
}