import Link from 'next/link'
import navStyles from "../styles/Nav.module.css";

const Nav = () =>{
    return (
        <nav className={navStyles.nav}>
            <ul>
                <li>
<Link href='/'>Account</Link>
                </li>
                
            </ul>
            <ul>
            <li>
<Link href='/participate'>Participate</Link>
                </li>
            </ul>
               
                <ul>
                <li>
<Link href='/activities'>Activities</Link>
                </li>
            </ul>
            <ul>
                <li>
<Link href='/comments'>Comments</Link>
                </li>
            </ul>
            <ul>
                <li>
<Link href='/trips_info'>Trips_Info</Link>
                </li>
            </ul>
            <ul>
                <li>
<Link href='/trips_comments'>Trips_Comments</Link>
                </li>
            </ul>
            <ul>
                <li>
<Link href='/trips_likes'>Trips_Likes</Link>
                </li>
            </ul>
            <ul>
                <li>
<Link href='/mention'>Mention</Link>
                </li>
            </ul>
            

        </nav>
    )
}
export default Nav