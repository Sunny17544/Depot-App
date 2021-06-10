
import { Controller } from "stimulus"

export default class extends Controller{
static values = {url: String}

load()
{
const csrfToken = document.querySelector("[name='csrf-token']").content
let product_id = 34;

fetch("http://localhost:3000/line_items", {
    method: 'POST', headers: { "X-CSRF-Token": csrfToken, "Content-type": "application/json"},
    body:JSON.stringify({product_id:product_id})
})


fetch("http://localhost:3000/cards")
.then(response => response.text())
.then(html => this.element.innerHTML = html)

}
}
