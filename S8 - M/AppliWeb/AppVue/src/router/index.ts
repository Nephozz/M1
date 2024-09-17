import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import { useAuthStore } from '@/store/AuthStore'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    
    {
      path: '/login',
      name: 'login',
      component: () => import('../views/LoginView.vue')
    },

    {
      path: '/admin',
      name: 'admin',
      component: () => import('../views/AdminView.vue')
    },
    {
      path: '/salles',
      name: 'salles',
      component: () => import('../views/AdminClassesView.vue')
    },
    {
      path: '/addSalle',
      name: 'addSalle',
      component: () => import('../views/AdminRoomView.vue')
    },
    {
      path: '/eleves',
      name: 'eleves',
      component: () => import('../views/AdminStudentsView.vue')
    },
    {
      path: '/seance',
      name: 'seance',
      component: () => import('../views/AdminSeanceView.vue')
    },
    {
      path: '/addTeacher',
      name: 'addTeacher',
      component: () => import('../views/AdminTeacherView.vue')
    }
  ]
})

// router.beforeEach((to, from, next) => {
//   if (to.name !== 'login' && !useAuthStore().isLogged) next({ name: 'login' })
//   else next()
// }
// )
export default router
