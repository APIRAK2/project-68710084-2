
<template>
  <div class="container mt-4">
    <h2 class="mb-3">รายการสินค้า</h2>

    <div class="mb-3">
      <button class="btn btn-primary" @click="openAddModal">Add+</button>
    </div>

    <table class="table table-bordered table-striped">
      <thead class="table-primary">
        <tr>
          <th>ID</th>
          <th>รหัสครุภัณฑ์</th>
          <th>ชื่อครุภัณฑ์</th>
          <th>วันที่ซื้อ</th>
          <th>ราคา</th>
          <th>รูปภาพ</th>
          <th>การจัดการ</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="asset in assets" :key="asset.asset_id">
          <td>{{ asset.asset_id }}</td>
          <td>{{ asset.asset_code }}</td>
          <td>{{ asset.asset_name }}</td>
          <td>{{ asset.purchase_date }}</td>
          <td>{{ asset.price }}</td>
          <td>
            <img
              v-if="asset.image"
              :src="'http://localhost/project-68710084-2/php_api/uploads/' + asset.image"
              width="100"
            />
          </td>
          <td>
            <button class="btn btn-warning btn-sm me-2" @click="openEditModal(asset)">
              แก้ไข
            </button>
            <button class="btn btn-danger btn-sm" @click="deleteProduct(asset.asset_id)">
              ลบ
            </button>
          </td>
        </tr>
      </tbody>
    </table>

    <div v-if="loading" class="text-center"><p>กำลังโหลดข้อมูล...</p></div>
    <div v-if="error" class="alert alert-danger">{{ error }}</div>

    <!-- Modal ใช้ทั้งเพิ่ม / แก้ไข -->
    <div class="modal fade" id="editModal" tabindex="-1">
      <div class="modal-dialog modal-md">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ isEditMode ? "แก้ไขสินค้า" : "เพิ่มครุภัณฑ์ใหม่" }}</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <form @submit.prevent="saveProduct">
              <div class="mb-3">
                <label class="form-label">รหัสครุภัณฑ์</label>
                <input v-model="editForm.asset_code" type="text" class="form-control" required />
              </div>
              <div class="mb-3">
                <label class="form-label">ชื่อครุภัณฑ์</label>
                <textarea v-model="editForm.asset_name" class="form-control"></textarea>
              </div>
              <div class="mb-3">
                <label class="form-label">วันที่ซื้อ</label>
                <input v-model="editForm.purchase_date" type="date" class="form-control" required />
              </div>
              <div class="mb-3">
                <label class="form-label">ราคา</label>
                <input v-model="editForm.price" type="number" class="form-control" required />
              </div>
              <div class="mb-3">
                <label class="form-label">รูปภาพ</label>
                <input
                  type="file"
                  @change="handleFileUpload"
                  class="form-control"
                  :required="!isEditMode"
                />

                <!-- แสดงรูปเดิมเฉพาะตอนแก้ไข -->
                <div v-if="isEditMode && editForm.image">
                  <p class="mt-2">รูปเดิม:</p>
                  <img
                    :src="'http://localhost/project-68710084-2/php_api/uploads/' + editForm.image"
                    width="100"
                  />
                </div>
              </div>

              <button type="submit" class="btn btn-success">
                {{ isEditMode ? "บันทึกการแก้ไข" : "บันทึกครุภัณฑ์ใหม่" }}
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
import { ref, onMounted } from "vue";

export default {
  name: "AssetList",

  setup() {
    const API_URL =
      "http://localhost/project-68710084-2/php_api/api_asset.php";

    const IMAGE_URL =
      "http://localhost/project-68710084-2/php_api/uploads/";

    const assets = ref([]);
    const loading = ref(false);
    const error = ref("");
    const isEditMode = ref(false);
    const saving = ref(false);

    const editForm = ref({
      asset_id: null,
      asset_code: "",
      asset_name: "",
      purchase_date: "",
      price: "",
      image: ""
    });

    const newImageFile = ref(null);
    let modalInstance = null;

    // ตรวจสอบและแปลง JSON จาก PHP
    const requestAPI = async (options = {}) => {
      const response = await fetch(API_URL, options);
      const text = await response.text();

      console.log("API Response:", text);

      let result;

      try {
        result = JSON.parse(text);
      } catch (e) {
        throw new Error(
          "PHP ส่งข้อมูลไม่ใช่ JSON กรุณาตรวจสอบ api_asset.php และ condb.php"
        );
      }

      if (!response.ok) {
        throw new Error(result.error || "เกิดข้อผิดพลาดจาก Server");
      }

      return result;
    };

    // โหลดข้อมูลจากฐานข้อมูล
    const fetchProducts = async () => {
      loading.value = true;
      error.value = "";

      try {
        const result = await requestAPI();

        if (result.success === true && Array.isArray(result.data)) {
          assets.value = result.data;
          console.log("ข้อมูลครุภัณฑ์:", assets.value);
        } else {
          assets.value = [];
          throw new Error(result.error || "ไม่พบข้อมูลจากฐานข้อมูล");
        }

      } catch (err) {
        console.error("Fetch Error:", err);
        error.value = err.message;
      } finally {
        loading.value = false;
      }
    };

    // เปิด Modal เพิ่มข้อมูล
    const openAddModal = () => {
      isEditMode.value = false;

      editForm.value = {
        asset_id: null,
        asset_code: "",
        asset_name: "",
        purchase_date: "",
        price: "",
        image: ""
      };

      newImageFile.value = null;

      const modalEl = document.getElementById("editModal");
      modalEl.querySelector('input[type="file"]').value = "";

      modalInstance =
        window.bootstrap.Modal.getOrCreateInstance(modalEl);

      modalInstance.show();
    };

    // เปิด Modal แก้ไขข้อมูล
    const openEditModal = (asset) => {
      isEditMode.value = true;
      editForm.value = { ...asset };
      newImageFile.value = null;

      const modalEl = document.getElementById("editModal");
      modalEl.querySelector('input[type="file"]').value = "";

      modalInstance =
        window.bootstrap.Modal.getOrCreateInstance(modalEl);

      modalInstance.show();
    };

    // เลือกรูปภาพ
    const handleFileUpload = (event) => {
      newImageFile.value =
        event.target.files?.[0] || null;
    };

    // เพิ่มและแก้ไขข้อมูล
    const saveProduct = async () => {
      if (saving.value) return;

      saving.value = true;

      const formData = new FormData();

      formData.append(
        "action",
        isEditMode.value ? "update" : "add"
      );

      if (isEditMode.value) {
        formData.append("asset_id", editForm.value.asset_id);
      }

      formData.append("asset_code", editForm.value.asset_code);
      formData.append("asset_name", editForm.value.asset_name);
      formData.append("purchase_date", editForm.value.purchase_date);
      formData.append("price", editForm.value.price);

      if (newImageFile.value) {
        formData.append("image", newImageFile.value);
      }

      try {
        const result = await requestAPI({
          method: "POST",
          body: formData
        });

        if (result.success) {
          alert(result.message || "บันทึกข้อมูลสำเร็จ");

          modalInstance?.hide();

          await fetchProducts();
        } else {
          alert(result.error || "บันทึกข้อมูลไม่สำเร็จ");
        }

      } catch (err) {
        console.error("Save Error:", err);
        alert(err.message);
      } finally {
        saving.value = false;
      }
    };

    // ลบข้อมูล
    const deleteProduct = async (id) => {
      if (!confirm("คุณแน่ใจหรือไม่ที่จะลบครุภัณฑ์นี้?")) {
        return;
      }

      const formData = new FormData();

      formData.append("action", "delete");
      formData.append("asset_id", id);

      try {
        const result = await requestAPI({
          method: "POST",
          body: formData
        });

        if (result.success) {
          alert(result.message || "ลบข้อมูลสำเร็จ");

          await fetchProducts();
        } else {
          alert(result.error || "ลบข้อมูลไม่สำเร็จ");
        }

      } catch (err) {
        console.error("Delete Error:", err);
        alert(err.message);
      }
    };

    onMounted(() => {
      fetchProducts();
    });

    return {
      API_URL,
      IMAGE_URL,
      assets,
      loading,
      error,
      saving,
      editForm,
      isEditMode,
      openAddModal,
      openEditModal,
      handleFileUpload,
      saveProduct,
      deleteProduct,
      fetchProducts
    };
  }
};
</script>

