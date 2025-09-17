// app/javascript/controllers/theme_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    this.applyThemeAndStyles()
  }

  toggle() {
    document.documentElement.classList.toggle('dark')

    if (document.documentElement.classList.contains('dark')) {
      localStorage.setItem('color-theme', 'dark')
    } else {
      localStorage.setItem('color-theme', 'light')
    }
    
    this.applyThemeAndStyles()
  }

  applyThemeAndStyles() {
    const isDark = document.documentElement.classList.contains('dark')


    if (isDark) {
      document.body.style.backgroundColor = '#111827'
    } else {
      document.body.style.backgroundColor = '#F3F4F6' 
    }

 
    document.querySelectorAll('[data-theme="title"]').forEach((el) => {
      el.style.color = isDark ? '#FFFFFF' : '#111827'
    })

    // 3. Forzar el color de los LABELS de formularios
    document.querySelectorAll('[data-theme="label"]').forEach((el) => {
      el.style.color = isDark ? '#FFFFFF' : '#111827'
    })


    document.querySelectorAll('[data-theme="table-header-text"]').forEach((el) => {
      el.style.color = isDark ? '#FFFFFF' : '#111827' 
    })

  }
}