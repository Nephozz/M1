<template>
    <div>
      <header>
        <input type="hidden" name="nom" :value="name" />
        <img class="logo" src="@/assets/n7.png" />
        <input type="checkbox" id="nav_check" hidden />
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <div class="nav-message">
          <span>{{ name }} - {{ id }}</span>
        </div>
        <nav>
          <ul>
            <li><router-link to="/admin" class="active">Accueil</router-link></li>
            <li><a @click="logOut">Se déconnecter</a></li>
          </ul>
        </nav>
        <label for="nav_check" class="hamburger">
          <div></div>
          <div></div>
          <div></div>
        </label>
      </header>
  
      <div class="buttons-box">
        <div class="button">
          <button class="submit-btn" @click="navigateTo('salles')">Salles</button>
        </div>
        <div class="button">
          <button @click="navigateTo('seance')" class="submit-btn">Cours</button>
        </div>
        <div class="button">
          <button @click="navigateTo('eleves')" class="submit-btn">Etudiants</button>
        </div>
        <div class="button">
          <button @click="navigateTo('addTeacher')" class="submit-btn">Professeurs</button>
        </div>
      </div>
    </div>
  </template>
  
  <script setup lang="ts">
  import { ref, onMounted } from 'vue'
  import { useRouter } from 'vue-router'
  import { useAuthStore } from '../store/AuthStore'
  
  const router = useRouter()
  const authStore = useAuthStore()
  
  const name = ref('')
  const id = ref(0)
  
  onMounted(() => {
    // Fetch user data from the store
    name.value = authStore.name
    id.value = authStore.id
  })
  
  const navigateTo = (page: string) => {
    console.log(page)
    router.push(`/${page}`)
  }
  
  const logOut = () => {
    authStore.logOut()
    router.push('/login')
  }
  </script>

  <style>
@import url("https://fonts.googleapis.com/css2?family=Poppins:wght@400;500&display=swap");

* {
  margin: 0;
  padding: 0;
  font-family: "Poppins", sans-serif;
  text-decoration: none;
  list-style: none;
  box-sizing: border-box;
}

body {
  background: #dfdfdf;
}

header {
  z-index: 1000;
  background: #fff;
  width: 100%;
  height: 70px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 50px;
  box-shadow: 0px 5px 10px 1px rgba(0, 0, 0, 0.05);
}

header .logo {
  width: 100px;
}

header nav ul {
  display: flex;
}

header nav ul li a {
  position: relative;
  color: #000;
  padding: 5px 0;
  margin: 0 10px;
  text-transform: uppercase;
  transition: 0.1s;
}

header nav ul li a:hover {
  border-bottom: 3px solid #2558a5;
}

header nav ul li a.active {
  border-bottom: 3px solid #2558a5;
}

.hamburger {
  cursor: pointer;
  display: none;
}

.hamburger div {
  width: 30px;
  height: 3px;
  margin: 5px 0;
  border-radius: 20px;
  background: #000;
}

.buttons-box {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  align-content: center;
  justify-content: center;
  position: relative;
  height: 80vh;
  width: 100vw;
}

.button {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 60px;
  width: 150px;
  margin: 10px;
  font-size: 20px;
  background-color: #fff;
  padding: 0 20px;
  border-radius: 20px;
  border: none;
  box-shadow: 0px 5px 10px 1px rgba(0, 0, 0, 0.2);
  outline: none;
  transition: 0.3s;
}

.button:hover {
  transform: scale(1.05);
}

.nav-message {
  margin-left: 15px;
  margin-right: 15px;
  text-align: center;
  font-size: 1em;
}

@media only screen and (max-width: 900px) {
  header {
    padding: 0 30px;
  }
}

@media only screen and (max-width: 700px) {
  .hamburger {
    display: block;
  }

  header nav {
    position: absolute;
    width: 100%;
    left: -100%;
    top: 70px;
    width: 100%;
    background: #fff;
    padding-left: 40px;
    padding-top: 20px;
    transition: 0.3s;
    box-shadow: 0px 5px 5px 1px rgba(0, 0, 0, 0.05);
  }

  header #nav_check:checked ~ nav {
    left: 0;
  }

  header nav ul {
    display: block;
  }

  header nav ul li a {
    margin: 0 10px;
  }

  header nav ul li {
    margin-bottom: 20px;
  }

  header nav ul li a {
    margin-left: auto;
    margin-right: auto;
  }

  .nav-message {
    font-size: 0.7em;
  }
}

  </style>
  