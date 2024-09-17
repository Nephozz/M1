<template>
  <div>
    <header>
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
      <img class="logo" src="@/assets/n7.png" />
      <input type="checkbox" id="nav_check" hidden />
      <div class="nav-message">
        <span>{{ nom }} - {{ prenom }}</span>
      </div>
      <nav>
        <ul>
          <li><router-link to="/admin" class="active">Accueil</router-link></li>
          <li><router-link to="/logout">Se déconnecter</router-link></li>
        </ul>
      </nav>
      <label for="nav_check" class="hamburger">
        <div></div>
        <div></div>
        <div></div>
      </label>
    </header>

    <div class="main-container">
      <form @submit.prevent="addCourse">
        <div class="add-lesson">
          <div class="input-box">
            <input type="text" class="input-field" v-model="nomCours" placeholder="Nom du cours" required />
          </div>
          <div class="input-box">
            <select class="role-field" id="role-select" v-model="selectedResponsable" required>
              <option value="" disabled hidden>Responsable</option>
              <option v-for="prof in listeProfs" :key="prof.id" :value="prof">
                {{ prof.nom }} {{ prof.prenom }}
              </option>
            </select>
          </div>


          <div class="check-boxes">
            <div v-for="filiere in filieres" :key="filiere.value" class="checkbox-choice">
              <input type="checkbox" class="input-field" :value="filiere.value" v-model="selectedFilieres" />
              <a>{{ filiere.label }}</a>
            </div>
          </div>

          <div class="add-submit">
            <button type="submit" class="add-btn">
              <i class="material-icons">add_circle</i>
            </button>
            <input type="hidden" name="op" value="addCours" />
          </div>
        </div>
      </form>

      <div class="teachers">
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Cours</th>
              <th>Filières</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(cours, index) in listeCours" :key="index">
              <td>{{ index + 1 }}</td>
              <td>{{ cours }}</td>
              <td>{{ listeMajors[listeIdCourses[index]].join(' ') }}</td>
              <td>
                <button @click.prevent="removeCourse(listeIdCourses[index])" class="remove-btn">
                  <i class="material-icons">do_not_disturb_on</i>
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useAuthStore } from '../store/AuthStore'
import { useRouter } from 'vue-router'

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8080/rest'

const router = useRouter()
const authStore = useAuthStore()

const prenom = ref(authStore.prenom)
const nom = ref(authStore.nom)

const nomCours = ref('')
const selectedFilieres = ref<string[]>([])
const listeCours = ref([])
const listeIdCourses = ref<number[]>([])
const selectedResponsable = ref<number | null>(null)
const listeProfs = ref<{ id: number, nom: string, prenom: string }[]>([])

const listeMajors = ref<Record<number, string[]>>({})

const filieres = [
  { label: 'A', value: 'A' },
  { label: 'B', value: 'B' },
  { label: 'L', value: 'L' },
  { label: 'M', value: 'M' },
  { label: 'R', value: 'R' },
  { label: 'T', value: 'T' },
]

const fetchProfs = async () => {
  listeProfs.value = [{id : 0, nom : 'test', prenom : 'test'},{id : 1, nom : 'Hagimont', prenom : 'Daniel'}]
  try {
    const response = await fetch(`${API_URL}/admin/professeurs`, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' },
    })
    const data = await response.json()
    console.log(data) // Inspecter les données
    listeProfs.value = data
    
  } catch (error) {
    console.error('Erreur lors de la récupération des profs:', error)
  }
}

const fetchCourses = async () => {
  try {
    const response = await fetch(`${API_URL}/admin/lessons`, {
      method: 'GET',
      headers: { 'Content-Type': 'application/json' },
    })
    const data = await response.json()
    console.log(data) // Inspecter les données
    listeCours.value = data.courses
    listeMajors.value = data.majors
    listeIdCourses.value = data.idCourses
  } catch (error) {
    console.error('Erreur lors de la récupération des cours:', error)
  }
}

const addCourse = async () => {
  try {
    const newCourse = {
      nom: nomCours.value,
      filieres: selectedFilieres.value,
      responsable: selectedResponsable.value,
    }
    const response = await fetch(`${API_URL}/admin/addMatieres`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(newCourse),
    })
    if (response.ok) {
      fetchCourses()
      nomCours.value = ''
      selectedFilieres.value = []
    } else {
      console.error('Erreur lors de l\'ajout du cours')
    }
  } catch (error) {
    console.error('Erreur lors de l\'ajout du cours:', error)
  }
}

const removeCourse = async (id: number) => {
  try {
    const response = await fetch(`${API_URL}/admin/rmvMatiere/${id}`, {
      method: 'DELETE',
      headers: { 'Content-Type': 'application/json' },
    })
    if (response.ok) {
      fetchCourses()
    } else {
      console.error('Erreur lors de la suppression du cours')
    }
  } catch (error) {
    console.error('Erreur lors de la suppression du cours:', error)
  }
}

onMounted(() => {
  fetchCourses()
  fetchProfs()
})
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

.main-container {
  display: flex;
  align-items: center;
  flex-direction: column;
  height: 100%;
  margin-bottom: 40px;
}

.add-lesson {
  margin-top: 20px;
}

.input-box .input-field {
  width: 100%;
  height: 40px;
  font-size: 12px;
  padding: 0 25px;
  margin-bottom: 15px;
  border-radius: 30px;
  border: none;
  box-shadow: 0px 5px 10px 1px rgba(0, 0, 0, 0.05);
  outline: none;
  transition: .3s;
}

.check-boxes {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;

}

button {
  background: none;
  border: none;
}

.remove-btn i {
  color: #ff0000;
  font-size: 20px;
}

.add-btn i {
  color: #00eb00;
  font-size: 30px;
}

.add-submit {
  text-align: center;
  position: relative;
}

table {
  border-collapse: collapse;
  margin: 25px 0;
  font-size: 0.9em;
  border-radius: 5px 5px 0 0;
  overflow: hidden;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
}

thead tr {
  background-color: #2558a5;
  color: #ffffff;
  text-align: left;
  font-weight: bold;
}

table th,
table td {
  padding: 12px 15px;
}

table tbody tr {
  border-bottom: 1px solid #848484;
}

table tbody tr:nth-of-type(even) {
  background-color: #e5e5e5;
}

table tbody tr:last-of-type {
  border-bottom: 2px solid #2558a5;
}

.nav-message {
  margin-left: 15px;
  margin-right: 15px;
  text-align: center;
  font-size: 1em;
}

.check-boxes {
  margin-top: 10px;
}

.role-field {
  width: 100%;
  height: 30px;
  font-size: 14px;
  padding: 0 20px;
  margin-bottom: 15px;
  border-radius: 20px;
  background-color: white;
  border: none;
  box-shadow: 0px 5px 10px 1px rgba(0, 0, 0, 0.05);
  outline: none;
  transition: .3s;
}

.buttons-box {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  justify-content: center;
  height: 80vh;
  width: 100%;
  margin-top: 20px;
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
  border-radius: 20px;
  border: none;
  box-shadow: 0px 5px 10px 1px rgba(0, 0, 0, 0.2);
  outline: none;
  transition: 0.3s;
}

.button:hover {
  transform: scale(1.05);
}

@media only screen and (max-width: 900px) {
  header {
    padding: 0 30px;
  }
}

@media only screen and (max-width: 580px) {
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

  header #nav_check:checked~nav {
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

  table {
    width: 100%;
    font-size: 0.8em;
  }

  table th,
  table td {
    padding: 10px 12px;
  }
}
</style>