import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

const app = createApp(App)

app.use(router)

import { createPinia } from 'pinia'
const pinia = createPinia()

app.use(pinia)
app.mount('#app')
