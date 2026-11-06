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
    
    component: () => import('../views/Customer_crud.vue'),
    meta: { requiresAuth: true }   
  },
  {
    path: '/employee_crud',
    name: 'employee_crud',
    
    component: () => import('../views/employee_crud.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/contacts_crud',
    name: 'contacts_crud',
    
    component: () => import('../views/contacts_crud.vue')
  },
  {
    path: '/Product',
    name: 'Product',
    
    component: () => import('../views/Product.vue'),
    meta: { requiresAuth: true }
  },
  {
    path: '/show_product',
    name: 'show_product',
    
    component: () => import('../views/show_product.vue')
  },
  {
    path: '/Asset',
    name: 'Asset',
    
    component: () => import('../views/Asset.vue')
  },
  {
    path: '/Login',
    name: 'Login',
    
    component: () => import('../views/Login.vue')
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

// ตรวจสอบสิทธิ์ก่อนเปลี่ยนหน้า
router.beforeEach((to, from, next) => {

  // ตรวจสอบสถานะ Login จาก localStorage
  const isLoggedIn = localStorage.getItem('adminLogin') === 'true'

  // ถ้าหน้านั้นต้อง Login แต่ยังไม่ได้ Login
  if (to.meta.requiresAuth && !isLoggedIn) {
    next('/login')
  }

  // ถ้า Login แล้ว ไม่ต้องกลับไปหน้า Login
  else if (to.path === '/login' && isLoggedIn) {
    next('/')
  }

  // กรณีอื่น ๆ อนุญาตให้เข้าหน้าได้
  else {
    next()
  }
})

export default router
