<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-info">
    <div class="container">
      <router-link class="navbar-brand fw-bold" to="/">Shabu House</router-link>
      <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarNav"
      >
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item">
            <router-link class="nav-link" to="/">Home</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link" to="/Customer_crud">Customer_crud</router-link>
          </li>
           <li class="nav-item">
            <router-link class="nav-link" to="/customer1">Customer</router-link>
          </li>

           <router-link class="nav-link" to="/Contacts.vue">Contacts</router-link>

           <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Employee
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/employee">Employee</a></li>
            <li><a class="dropdown-item" href="/employee_crud">Employee CRUD</a></li>
          </ul>
           </li>
           <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Contacts
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/Contacts">Contacts</a></li>
            <li><a class="dropdown-item" href="/contacts_crud">Contacts DRUD</a></li>
          </ul>
        

        </li>
           <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Product
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/Product">Product</a></li>
            <li><a class="dropdown-item" href="/show_product">Show product</a></li>
            <li><a class="dropdown-item" href="/asset">Asset</a></li>
          </ul>
        </li>


           <li class="nav-item">
            <router-link class="nav-link" to="/about">About</router-link>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  name: "Navbar"
}
</script>