import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/about',
    name: 'about',
    
    component: () => import('../views/AboutView.vue')
  },
  {
    path: '/customer1',
    name: 'customer1',
    
    component: () => import('../views/Customer.vue')
  },
  {
    path: '/employee',
    name: 'employee',
    
    component: () => import('../views/Employee.vue')
  },
  {
    path: '/add_Customer',
    name: 'add_Customer',
    
    component: () => import('../views/Add_Customer.vue')
  },
  {
    path: '/add_employee',
    name: 'add_employee',
    
    component: () => import('../views/Add_Employee.vue')
  },
  {
    path: '/Contacts',
    name: 'Contacts',
    
    component: () => import('../views/Contacts.vue')
  },
  {
    path: '/add_contacts',
    name: 'add_contacts',
    
    component: () => import('../views/Add_Contacts.vue')
  },
  {
    path: '/customer_crud',
    name: 'customer_crud',
    
    component: () => import('../views/Customer_crud.vue')
  },
  {
    path: '/employee_crud',
    name: 'employee_crud',
    
    component: () => import('../views/employee_crud.vue')
  },
  {
    path: '/contacts_crud',
    name: 'contacts_crud',
    
    component: () => import('../views/contacts_crud.vue')
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
