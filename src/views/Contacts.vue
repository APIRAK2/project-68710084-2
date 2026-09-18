<template>
  <div class="container mt-4">

    <!-- หัวข้อหน้า -->
    <h2 class="mb-3">ข้อมูลติดต่อเรา</h2>

    <!-- ตารางแสดงข้อมูล Contact Us -->
     <div class="text-end mb-3">
      <a href="/add_contacts" class="btn btn-info" >Add+</a>
     </div>
    <table class="table table-bordered table-striped">
        <div class="text-end mb-3">
     </div>

      <thead class="table-dark">
        <tr>
          <th>ลำดับที่</th>
          <th>เรื่อง</th>
          <th>รายละเอียด</th>
          <th>ชื่อจริง</th>
          <th>Email</th>
        </tr>
      </thead>

      <tbody>

        <!-- วนลูปข้อมูล contacts -->
        <tr
          v-for="(item, index) in contacts"
          :key="item.contact_id"
        >
          <td>{{ index + 1 }}</td>
          <td>{{ item.subject }}</td>
          <td>{{ item.detail }}</td>
          <td>{{ item.fullname }}</td>
          <td>{{ item.email }}</td>
        </tr>

      </tbody>
    </table>

    <!-- Loading -->
    <div v-if="loading" class="text-center">
      <p>กำลังโหลดข้อมูล...</p>
    </div>

    <!-- Error -->
    <div v-if="error" class="alert alert-danger">
      {{ error }}
    </div>

  </div>
</template>


<script>
import { ref, onMounted } from "vue";

export default {
  name: "ContactList",

  setup() {

    // -----------------------------
    // state
    // -----------------------------
    const contacts = ref([]);
    const loading = ref(true);
    const error = ref(null);


    // -----------------------------
    // ดึงข้อมูลจาก API
    // -----------------------------
    const fetchdata = async () => {

      try {

        const response = await fetch(
          "http://localhost/project-68710084-2/php_api/show_contacts.php"
        );

        // ตรวจสอบการเรียก API
        if (!response.ok) {
          throw new Error("ไม่สามารถดึงข้อมูลได้");
        }

        // แปลง JSON
        contacts.value = await response.json();

      } catch (err) {

        error.value = err.message;

      } finally {

        loading.value = false;

      }
    };


    // -----------------------------
    // เรียก API ตอนเปิดหน้า
    // -----------------------------
    onMounted(() => {
      fetchdata();
    });


    // -----------------------------
    // ส่งค่าไป template
    // -----------------------------
    return {
      contacts,
      loading,
      error
    };

  }
};
</script>
