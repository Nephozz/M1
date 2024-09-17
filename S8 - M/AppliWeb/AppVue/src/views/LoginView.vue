<template>

    <div class="login-box">
        <div class="login-header">
            <header>Connexion</header>
        </div>
        
        <form
            @click="
            (e) => {
                e.preventDefault()
                LoginAction
            }
            "
        >
    
            <div class="input-box">
                <input type="text" name="name" class="input-field" placeholder="Nom d'utilisateur" required v-model="name">
            </div>
            <div class="input-box">
                <input type="password" name="mdp" class="input-field" placeholder="Mot de passe" required v-model="mdp">
            </div>
            <div class="input-box">
                <select class="role-field" name="role" id="role-select" required v-model="role">
                    <option value="choice-message" selected disabled hidden>Choisissez votre rôle</option>
                    <option value="etudiant">Étudiant</option>
                    <option value="prof">Professeur</option>
                    <option value="admin">Administrateur</option>
                    </select>
            </div>
            <div class="input-submit">
                <button class="submit-btn" id="submit" @click="LoginAction"></button>
                <input type="hidden" name="op" value="login">
                <label for="submit">Se connecter</label>
            </div>
        
        </form>
        
        
    </div>

</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '../store/AuthStore'

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8080/projetAW/rest/'

const router = useRouter()

const LoginAction = async () => {
    console.log(name.value)
    const response = await fetch( `${API_URL}/login`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            name: name.value,
            mdp: mdp.value,
            role: role.value
          })
        });
        const data = await response.json();
        useAuthStore().login(data.prenom, data.idLog, data.role, data.nom)
        if (response.ok) {
           if (data.role === 'etudiant') {
               router.push('/etudiant')
           } else if (data.role === 'prof') {
               router.push('/prof')
           } else if (data.role === 'admin') {
               router.push('/admin')
           }
        } else {
            alert('Erreur de connexion')
        }
}

const name = ref('')
const mdp = ref('')
const role = ref('')



</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500&display=swap');

*{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins',sans-serif;
}
body{
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    background: #dfdfdf;
}
.login-box{
    display: flex;
    justify-content: center;
    flex-direction: column;
    width: 90%;
    height: 90%;
    padding: 30px;
}
.login-header{
    text-align: center;
    margin: 20px 0 40px 0;
}
.login-header header{
    color: #333;
    font-size: 30px;
    font-weight: 600;
}
.input-box .input-field{
    width: 100%;
    height: 60px;
    font-size: 17px;
    padding: 0 25px;
    margin-bottom: 15px;
    border-radius: 30px;
    border: none;
    box-shadow: 0px 5px 10px 1px rgba(0,0,0, 0.05);
    outline: none;
    transition: .3s;
}
::placeholder{
    font-weight: 500;
    color: #222;
}
.input-field:focus{
    width: 105%;
}
section{
    display: flex;
    align-items: center;
    font-size: 14px;
    color: #555;
}
a{
    text-decoration: none;
}
a:hover{
    text-decoration: underline;
}
section a{
    color: #555;
}
.input-submit{
    margin-top: 30px;
    text-align: center;
    position: relative;
}
.submit-btn{
    width: 100%;
    height: 60px;
    background: #222;
    border: none;
    border-radius: 30px;
    cursor: pointer;
    transition: .3s;
}
.input-submit label{
    position: absolute;
    top: 45%;
    left: 50%;
    color: #fff;
    -webkit-transform: translate(-50%, -50%);
    -ms-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
    cursor: pointer;
}
.submit-btn:hover{
    background: #000;
    transform: scale(1.05,1);
}

.role-field{
    width: 100%;
    height: 30px;
    font-size: 14px;
    padding: 0 20px;
    margin-bottom: 15px;
    border-radius: 20px;
    border: none;
    box-shadow: 0px 5px 10px 1px rgba(0,0,0, 0.05);
    outline: none;
    transition: .3s;
}

</style>