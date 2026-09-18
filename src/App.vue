<template>
  <div>

<!--แสดงเมนู-->
<navbar />

<!--แสดงหน้าเพจ-->
  <router-view />

  <!--แสดง footer-->
<Footer />

  </div>
  
</template>

<script>
import Navbar from './components/Navbar.vue';
import Footer from './components/footer.vue';

export default {
  name: "App",
  components: {Navbar,Footer}
};
</script>