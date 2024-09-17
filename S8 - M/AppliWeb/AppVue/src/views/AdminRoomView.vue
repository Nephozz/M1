<template>
    <div>
      <header>
        <input type="hidden" name="nom" :value="name" />
        <img class="logo" src="@/assets/n7.png" />
        <input type="checkbox" id="nav_check" hidden />
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
  
      <div class="main-container">
        <div class="add-salles">
          <form @submit.prevent="addSalle">
            <div class="input-box">
              <input
                type="text"
                class="input-field"
                v-model="nomSalle"
                placeholder="Nom de la salle"
                required
              />
            </div>
            <div class="input-box">
              <input
                type="text"
                class="input-field"
                v-model="capaciteSalle"
                placeholder="Capacité"
                required
              />
            </div>
            <div class="add-submit">
              <button class="add-btn">
                <i class="material-icons">add_circle</i>
              </button>
            </div>
          </form>
        </div>
      </div>
  
      <div class="salles">
        <div class="salle-container" v-for="salle in salles" :key="salle.id">
          <div class="salle">
            <div class="salle-header">{{ salle.numero }}</div>
            <div class="salle-main">
              <i class="material-icons">person</i>
              <div class="capacity">{{ salle.capacite }}</div>
            </div>
          </div>
          <div class="remove-submit">
            <button @click="removeSalle(salle.id)" class="remove-btn">
              <i class="material-icons">do_not_disturb_on</i>
            </button>
          </div>
        </div>
      </div>
    </div>
</template> 
  
<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { useAuthStore } from '../store/AuthStore';

const router = useRouter();
const authStore = useAuthStore();

const name = ref('');
const id = ref(0);
const nomSalle = ref('');
const capaciteSalle = ref('');
const salles = ref([]);

onMounted(() => {
  name.value = authStore.name;
  id.value = authStore.id;
  fetchSalles();
});

const fetchSalles = async () => {
  try {
    const response = await fetch('/api/salles');
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    const data = await response.json();
    salles.value = data;
  } catch (error) {
    console.error('Error fetching salles:', error);
  }
};

const addSalle = async () => {
  try {
    const response = await fetch('/api/salles', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        nomSalle: nomSalle.value,
        capaciteSalle: capaciteSalle.value
      })
    });
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    fetchSalles(); // Refresh the list after adding a salle
  } catch (error) {
    console.error('Error adding salle:', error);
  }
};

const removeSalle = async (idSalle: number) => {
  try {
    const response = await fetch(`/api/salles/${idSalle}`, {
      method: 'DELETE'
    });
    if (!response.ok) {
      throw new Error('Network response was not ok');
    }
    fetchSalles(); // Refresh the list after removing a salle
  } catch (error) {
    console.error('Error removing salle:', error);
  }
};

const logOut = () => {
  authStore.logOut();
  router.push('/login');
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

.add-salles{
  margin-top: 20px;
}

.input-box .input-field{
  width: 100%;
  height: 40px;
  font-size: 12px;
  padding: 0 25px;
  margin-bottom: 15px;
  border-radius: 30px;
  border: none;
  box-shadow: 0px 5px 10px 1px rgba(0,0,0, 0.05);
  outline: none;
  transition: .3s;
}

.salles {
  z-index: 1;
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  align-content: center;
  justify-content: center;
  width: 100vw;
  margin-top: 20px;
}

.salle {
  width: 150px;                 /* Set width of cards */
  border: 1px solid #2558a5;    /* Set up Border */
  border-radius: 4px;           /* Slightly Curve edges */
  overflow: hidden;             /* Fixes the corners */  
  display: flex;                /* Children use Flexbox */
  flex-direction: column;       /* Rotate Axis */
  margin: 10px 10px 0px 10px;                 /* Add margin around cards */
}

.salle-header {
  color: #ffffff;
  text-align: center;
  font-size: 12px;
  font-weight: 600;
  border-bottom: 1px solid #2558a5;
  background-color: #2558a5;
  padding: 5px 10px;
}

.salle-main {
  display: flex;              /* Children use Flexbox */
  flex-direction: row;     /* Rotate Axis to Vertical */
  justify-content: center;    /* Group Children in Center */
  align-items: center;        /* Group Children in Center (+axis) */
  padding: 15px 0;            /* Add padding to the top/bottom */
  background-color: #ffffff;
}

button {
  background: none;
  border: none;
}

.material-icons {
  font-size: 30px !important;
  margin-bottom: 4px;
}

.remove-btn i {
  color: #ff0000;
}

.add-btn i {
  color: #00eb00;
}

.salle-main i {
  color: #2558a5;
}

.remove-submit, .add-submit{
  text-align: center;
  font-size: 35px;
  position: relative;
}


.nav-message{
  margin-left: 15px;
  margin-right: 15px;
  text-align: center;
  font-size: 1em;
}


/* footer {
  background-color: #333;
  color: white;
  font-size: 0.8em;
  padding: 15px;
  position: relative; 
  bottom: -70px;
  width: 100%;
} */

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
  .nav-message{
    font-size: 0.7em;
  }
}

</style>
