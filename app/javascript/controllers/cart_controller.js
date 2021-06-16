
import { Controller } from "stimulus"
export default class extends Controller
{
    static targets = [ "output" ]
    static values = {url: String}

  load()
  {
    const csrfToken = document.querySelector("[name='csrf-token']").getAttribute("content")
    //let id = 31;

    //fetch("http://localhost:3000/order_items", 
    //{
        //method: 'POST',
       //headers: { "X-CSRF-Token": csrfToken, 
       //"Content-type": "application/json"},
       //body:JSON.stringify({product_id: id})
   // })


    fetch("http://localhost:3000/cards")

    .then(response => response.text())
    .then(html => this.element.innerHTML = html)

  }


  connect()
  {
    console.log("text")
  }

}
