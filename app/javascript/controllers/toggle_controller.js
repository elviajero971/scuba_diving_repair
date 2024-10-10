import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["button", "content"]
    static classes = ["hidden"]

    toggle() {
        this.contentTarget.classList.toggle(this.hiddenClass)
    }
}