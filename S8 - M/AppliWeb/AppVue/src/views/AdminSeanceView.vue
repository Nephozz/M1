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
        <a>{{ prenom }} {{ nom }} - {{ idLog }}</a>
      </div>
      <nav>
        <ul>
          <li>
            <router-link to="/admin" class="active">Accueil</router-link>
          </li>
          <li>
            <router-link to="/login">Se déconnecter</router-link>
          </li>
        </ul>
      </nav>
      <label for="nav_check" class="hamburger">
        <div></div>
        <div></div>
        <div></div>
      </label>
    </header>

    <div class="main-container">
      <form @submit.prevent="submitForm">
        <div class="add-student">
          <div class="input-box">
            <input
              class="role-field"
              id="date-select"
              type="date"
              name="date"
              v-model="newDate"
              value="2024-01-01"
              required
            />
          </div>
          <div class="input-box">
            <select v-model="selectedCreneau" class="role-field" required>
              <option disabled value="">Créneau</option>
              <option value="c1">8h-9h45</option>
              <option value="c2">10h15-12h</option>
              <option value="c3">14h-15h45</option>
              <option value="c4">16h15-18h</option>
            </select>
          </div>

          <div class="input-box">
            <select v-model="selectedProf" class="role-field" required>
              <option disabled value="">Professeur</option>
              <option
                v-for="prof in listeProfs"
                :key="prof.id"
                :value="prof.id"
              >
                {{ prof.nom }} {{ prof.prenom }}
              </option>
            </select>
          </div>

          <div class="input-box">
            <select v-model="selectedMatiere" class="role-field" required>
              <option disabled value="">Matière</option>
              <option
                v-for="matiere in listeMatieres"
                :key="matiere.id"
                :value="matiere.id"
              >
                {{ matiere.nom }}
              </option>
            </select>
          </div>

          <div class="input-box">
            <select v-model="selectedSalle" class="role-field" required>
              <option disabled value="">Salle</option>
              <option
                v-for="salle in listeSalles"
                :key="salle.id"
                :value="salle.id"
              >
                {{ salle.numero }}
              </option>
            </select>
          </div>

          <div class="add-submit">
            <button class="add-btn" type="submit">
              <i class="material-icons">add_circle</i>
            </button>
            <input type="hidden" name="op" value="addSeance" />
          </div>
        </div>

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
              <tr v-for="(cours, index) in listeCours" :key="cours.id">
                <td>{{ index + 1 }}</td>
                <td>{{ cours.nom }}</td>
                <td>{{ getFilieresString(cours.filieres) }}</td>
                <td>
                  <button
                    @click.prevent="removeSeance(cours.id)"
                    class="remove-btn"
                  >
                    <i class="material-icons">do_not_disturb_on</i>
                  </button>
                  <input type="hidden" name="op" value="suprSeance" />
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import { useAuthStore } from "../store/AuthStore";

const API_URL = import.meta.env.VITE_API_URL || "http://localhost:8080/rest/";

const router = useRouter();

const nom = ref("");
const prenom = ref("");
const idLog = ref("");
const selectedCreneau = ref("");
const selectedProf = ref("");
const selectedMatiere = ref("");
const selectedSalle = ref("");
const listeProfs = ref([]);
const listeMatieres = ref([]);
const listeSalles = ref([]);
const listeCours = ref([]);

const fetchData = async () => {
  try {
    const profsResponse = await fetch(`${API_URL}/profs`);
    listeProfs.value = await profsResponse.json();

    const matieresResponse = await fetch(`${API_URL}/matieres`);
    listeMatieres.value = await matieresResponse.json();

    const sallesResponse = await fetch(`${API_URL}/salles`);
    listeSalles.value = await sallesResponse.json();

    const coursResponse = await fetch(`${API_URL}/cours`);
    listeCours.value = await coursResponse.json();
  } catch (error) {
    console.error("Error fetching data:", error);
  }
};

const submitForm = async () => {
  const formData = {
    creneau: selectedCreneau.value,
    prof: selectedProf.value,
    matiere: selectedMatiere.value,
    salle: selectedSalle.value,
    op: "addSeance",
  };

  try {
    const response = await fetch(`${API_URL}/seance`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(formData),
    });
    const data = await response.json();
    // Handle response and update UI if necessary
  } catch (error) {
    console.error("Error submitting form:", error);
  }
};

const removeSeance = async (idCours) => {
  try {
    await fetch(`${API_URL}/seance`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ op: "suprSeance", idCours }),
    });
    // Handle response and update UI if necessary
  } catch (error) {
    console.error("Error removing seance:", error);
  }
};

const getFilieresString = (filieres) => {
  return filieres.map((filiere) => filiere.nom).join(" ");
};

onMounted(() => {
  fetchData();
  // Set nom, prenom, and idLog from route params or another source
});
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
