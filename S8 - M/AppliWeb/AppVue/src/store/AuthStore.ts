import { defineStore } from "pinia"

export const useAuthStore = defineStore({
    id: 'auth',
    state: () => ({
        prenom: '',
        nom: '',
        id : 0,
        role : '',

    }),
    actions: {
        login(prenom: string, id: number, role: string,  nom: string) {
        this.prenom = prenom
        this.id = id
        this.role = role
        this.nom = nom
        },

        logOut() {
            this.prenom = ''
            this.id = 0
            this.role = ''
            this.nom = ''
        }
    },

    getters: {
        isLogged(): boolean {
            return this.prenom !== ''
        }
    }
})