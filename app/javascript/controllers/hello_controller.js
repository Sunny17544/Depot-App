// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
export default class extends Controller {
  static targets = [ "detail", "cart" ]
  static values = { url: String , count: Number}



  greet()
  {
    // var nameStr=1;
    // alert(nameStr)
    // console.log("Sandeep Roy")
    alert(this.detailTarget.textContent) 
  }





CartAdd(event)
{
  console.log("Working")
  const csrf = document.querySelector("[name='csrf-token']").getAttribute("content");
  var product_id= event.target.id;
  const data={product_id: product_id , quantity: 1}
  var url=this.urlValue;

  fetch(url,
  {
    method: 'POST',
    headers:
    {
      'X-CSRF-Token': csrf,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data),
  })
  .then((response) => 
  {
    if (response.status == 200 ) 
    { 
      this.countValue=this.countValue+1 ; 
      this.cartTarget.textContent=this.countValue;
    } 
    else if(response.status == 404) 
    { 
      alert("not added") 
    }
  })
    
}

  
}
