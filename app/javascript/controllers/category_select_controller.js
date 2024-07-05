// category_select_controller.js
import { Controller } from "@hotwired/stimulus"
import { debounce } from "lodash-es"

export default class extends Controller {
  static targets = ["select", "fields"]
  static values = { currentCategory: Number }

  connect() {
    this.updateFieldsDebounced = debounce(this.updateFields.bind(this), 300)
    if (this.currentCategoryValue) {
      this.selectTarget.value = this.currentCategoryValue
      this.updateFields()
    }
  }

  updateFields() {
    const categoryId = this.selectTarget.value
    if (categoryId) {
      if (this.cachedHtml && this.cachedHtml[categoryId]) {
        this.renderCachedHtml(categoryId)
      } else {
        this.fetchAndRenderFields(categoryId)
      }
    } else {
      this.fieldsTarget.innerHTML = ""
    }
  }

  renderCachedHtml(categoryId) {
    this.fieldsTarget.innerHTML = this.cachedHtml[categoryId]
  }

  fetchAndRenderFields(categoryId) {
    const url = `/resources/category_fields?category_id=${categoryId}`
    fetch(url, {
      headers: { 
        "Accept": "text/vnd.turbo-stream.html",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      }
    })
    .then(response => response.text())
    .then(html => {
      Turbo.renderStreamMessage(html)
      this.cachedHtml = this.cachedHtml || {}
      this.cachedHtml[categoryId] = html
    })
    .catch(error => {
      console.error('Error:', error)
      this.fieldsTarget.innerHTML = '<p>Error loading category fields. Please try again.</p>'
    })
  }
}