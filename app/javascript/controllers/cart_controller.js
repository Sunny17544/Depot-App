
import { Controller } from "stimulus"
export default class extends Controller
{
    static targets = [ "output" ]
    static values = {url: String}

  load()
  {
    const csrfToken = document.querySelector("[name='csrf-token']").getAttribute("content")


    fetch("http://localhost:3000/cards")

    .then(response => response.text())
    .then(html => this.element.innerHTML = html)

  }


  connect()
  {
    console.log("text")
  }

}
