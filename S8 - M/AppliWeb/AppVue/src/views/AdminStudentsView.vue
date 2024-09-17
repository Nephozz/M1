<template>
  <div>
    <header>
      <img class="logo" src="@/assets/n7.png" />
      <input type="checkbox" id="nav_check" hidden />
      <link
        href="https://fonts.googleapis.com/icon?family=Material+Icons"
        rel="stylesheet"
      />
      <div class="nav-message">
        <span>{{ prenom }} {{ nom }} - {{ idLog }}</span>
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

    <div class="main-container">
      <form @submit.prevent="addStudent">
        <div class="add-student">
          <div class="input-box">
            <input
              type="text"
              class="input-field"
              v-model="newNom"
              placeholder="Nom"
              required
            />
          </div>
          <div class="input-box">
            <input
              type="text"
              class="input-field"
              v-model="newPrenom"
              placeholder="Prénom"
              required
            />
          </div>
          <div class="input-box">
            <input
              type="text"
              class="input-field"
              v-model="newUsername"
              placeholder="Identifiant de connexion"
              required
            />
          </div>
          <div class="input-box">
            <input
              type="text"
              class="input-field"
              v-model="newPassword"
              placeholder="Mot de passe"
              required
            />
          </div>
          <div class="input-box">
            <select
              class="role-field"
              id="role-select"
              v-model="filiere"
              required
            >
              <option value="" selected disabled hidden>Filière</option>
              <option value="IMM">Image & Multimédia</option>
              <option value="Logiciel">Logiciel</option>
              <option value="Bigdata">HPC & Big Data</option>
              <option value="ASR">ASR</option>
              <option value="Telecom">Télécommunication</option>
              <option value="Reseaux">Réseaux</option>
            </select>
          </div>
          <div class="add-submit">
            <button class="add-btn">
              <i class="material-icons">add_circle</i>
            </button>
          </div>
        </div>
      </form>

      <div class="students">
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Nom</th>
              <th>Prénom</th>
              <th>Filière</th>
              <th>Absences</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(etudiant, index) in etudiants" :key="etudiant.id">
              <td>{{ index + 1 }}</td>
              <td>{{ etudiant.nom }}</td>
              <td>{{ etudiant.prenom }}</td>
              <td>{{ etudiant.filiere }}</td>
              <td>{{ etudiant.absences.length * 1.75 }}h</td>
              <td>
                <button class="remove-btn" @click="removeStudent(etudiant.id)">
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
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import { useAuthStore } from "../store/AuthStore";

const router = useRouter();
const authStore = useAuthStore();

const nom = ref("");
const prenom = ref("");
const idLog = ref("");
const newNom = ref("");
const newPrenom = ref("");
const filiere = ref("");
const etudiants = ref([]);

onMounted(() => {
  // Fetch user data from the store
  nom.value = authStore.nom;
  prenom.value = authStore.prenom;
  idLog.value = authStore.idLog;
  fetchEtudiants();
});

const fetchEtudiants = async () => {
  try {
    const response = await fetch("/api/etudiants");
    if (!response.ok) {
      throw new Error("Network response was not ok");
    }
    const data = await response.json();
    etudiants.value = data;
  } catch (error) {
    console.error("Error fetching etudiants:", error);
  }
};

const addStudent = async () => {
  try {
    const response = await fetch("/api/etudiants", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        nom: newNom.value,
        prenom: newPrenom.value,
        filiere: filiere.value,
      }),
    });
    if (!response.ok) {
      throw new Error("Network response was not ok");
    }
    fetchEtudiants(); // Refresh the list after adding a student
  } catch (error) {
    console.error("Error adding student:", error);
  }
};

const removeStudent = async (idEtudiant: number) => {
  try {
    const response = await fetch(`/api/etudiants/${idEtudiant}`, {
      method: "DELETE",
    });
    if (!response.ok) {
      throw new Error("Network response was not ok");
    }
    fetchEtudiants(); // Refresh the list after removing a student
  } catch (error) {
    console.error("Error removing student:", error);
  }
};

const logOut = () => {
  authStore.logOut();
  router.push("/login");
};
</script>

<style scoped>
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
  display: relative;
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

.add-student {
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
  transition: 0.3s;
}

.role-field {
  width: 100%;
  height: 30px;
  font-size: 14px;
  padding: 0 20px;
  margin-bottom: 15px;
  border-radius: 20px;
  border: none;
  box-shadow: 0px 5px 10px 1px rgba(0, 0, 0, 0.05);
  outline: none;
  transition: 0.3s;
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

  table {
    width: 100%;
    font-size: 0.7em;
  }

  table th,
  table td {
    padding: 5px 7px;
  }
}
</style>
