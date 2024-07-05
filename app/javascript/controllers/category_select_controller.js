import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "fields"]

  connect() {
    if (this.selectTarget.value) {
      this.updateFields()
    }
  }

  updateFields() {
    const categoryId = this.selectTarget.value
    if (categoryId) {
      const url = `/resources/category_fields?category_id=${categoryId}`
      fetch(url, {
        headers: { 
          "Accept": "text/vnd.turbo-stream.html",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        }
      })
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.text()
      })
      .then(html => Turbo.renderStreamMessage(html))
      .catch(error => {
        console.error('Error:', error);
        this.fieldsTarget.innerHTML = '<p>Error loading category fields. Please try again.</p>';
      })
    } else {
      this.fieldsTarget.innerHTML = ""
    }
  }
}