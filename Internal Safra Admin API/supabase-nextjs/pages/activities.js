// import { useState, useEffect } from 'react'
// import { useUser, useSupabaseClient } from '@supabase/auth-helpers-react'
// import '../styles/Home.module.css'
// import Nav from './Navbar'


// export default function Account({ session }) {
//   const supabase = useSupabaseClient()
//   const user = useUser()
//   const [loading, setLoading] = useState(true)
//   const [username, setUsername] = useState(null)
//   const [website, setWebsite] = useState(null)
//   const [avatar_url, setAvatarUrl] = useState(null)

//   useEffect(() => {
//     getProfile()
//   }, [session])

//   async function getProfile() {
//     try {
//       setLoading(true)

//       let { data, error, status } = await supabase
//         .from('profiles')
//         .select(`username`)
//         .eq('id', user.id)
//         .single()

//       if (error && status !== 406) {
//         throw error
//       }

//       if (data) {
//         setUsername(data.username)
//       }
//     } catch (error) {
//       alert('Error loading user data!')
//       console.log(error)
//     } finally {
//       setLoading(false)
//     }
//   }

//   async function updateProfile({ username, website, avatar_url }) {
//     try {
//       setLoading(true)

//       const updates = {
//         id: user.id,
//         username,
//         updated_at: new Date().toISOString(),
//       }

//       let { error } = await supabase.from('profiles').upsert(updates)
//       if (error) throw error
//       alert('Profile updated!')
//     } catch (error) {
//       alert('Error updating the data!')
//       console.log(error)
//     } finally {
//       setLoading(false)
//     }
//   }

//   return (
//     <>
//     <Nav />
//     <div className="form-widget">
//       <div className="Account">
      
// <label>hello</label>
        
//         </div>

//     </div>
//     </>
//   )
// }