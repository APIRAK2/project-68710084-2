
<?php

header("Content-Type: application/json; charset=UTF-8");

ini_set('display_errors', 0);
error_reporting(E_ALL);

include 'condb.php';

// ตั้งค่า PDO
$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

// ฟังก์ชันส่ง JSON
function responseJSON($data, $status = 200) {
    http_response_code($status);
    echo json_encode($data, JSON_UNESCAPED_UNICODE);
    exit;
}

// ฟังก์ชันอัปโหลดรูปภาพ
function uploadImage() {
    if (!isset($_FILES['image']) ||
        $_FILES['image']['error'] === UPLOAD_ERR_NO_FILE) {
        return null;
    }

    if ($_FILES['image']['error'] !== UPLOAD_ERR_OK) {
        throw new Exception("อัปโหลดรูปภาพไม่สำเร็จ");
    }

    $targetDir = __DIR__ . "/uploads/";

    if (!is_dir($targetDir)) {
        mkdir($targetDir, 0777, true);
    }

    $extension = strtolower(
        pathinfo($_FILES['image']['name'], PATHINFO_EXTENSION)
    );

    $allowed = ['jpg', 'jpeg', 'png', 'gif', 'webp'];

    if (!in_array($extension, $allowed)) {
        throw new Exception("รองรับเฉพาะไฟล์ JPG, PNG, GIF และ WEBP");
    }

    $filename = uniqid('asset_', true) . '.' . $extension;

    $targetFile = $targetDir . $filename;

    if (!move_uploaded_file($_FILES['image']['tmp_name'], $targetFile)) {
        throw new Exception("ไม่สามารถบันทึกรูปภาพได้");
    }

    return $filename;
}

try {

    // =========================
    // POST : เพิ่ม / แก้ไข / ลบ
    // =========================

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {

        $action = $_POST['action'] ?? '';

        switch ($action) {

            // =========================
            // ADD : เพิ่มครุภัณฑ์
            // =========================

            case 'add':

                $asset_code = $_POST['asset_code'] ?? '';
                $asset_name = $_POST['asset_name'] ?? '';
                $purchase_date = $_POST['purchase_date'] ?? '';
                $price = $_POST['price'] ?? 0;

                $filename = uploadImage();

                $sql = "INSERT INTO assets
                        (asset_code, asset_name, purchase_date, price, image)
                        VALUES
                        (:asset_code, :asset_name, :purchase_date, :price, :image)";

                $stmt = $conn->prepare($sql);

                $stmt->execute([
                    ':asset_code' => $asset_code,
                    ':asset_name' => $asset_name,
                    ':purchase_date' => $purchase_date,
                    ':price' => $price,
                    ':image' => $filename
                ]);

                responseJSON([
                    "success" => true,
                    "message" => "เพิ่มข้อมูลครุภัณฑ์สำเร็จ"
                ]);

                break;


            // =========================
            // UPDATE : แก้ไขครุภัณฑ์
            // =========================

            case 'update':

                $asset_id = $_POST['asset_id'] ?? '';
                $asset_code = $_POST['asset_code'] ?? '';
                $asset_name = $_POST['asset_name'] ?? '';
                $purchase_date = $_POST['purchase_date'] ?? '';
                $price = $_POST['price'] ?? 0;

                // อัปโหลดรูปใหม่ (ถ้ามี)
                $filename = uploadImage();

                if ($filename !== null) {

                    $sql = "UPDATE assets SET
                            asset_code = :asset_code,
                            asset_name = :asset_name,
                            purchase_date = :purchase_date,
                            price = :price,
                            image = :image
                            WHERE asset_id = :asset_id";

                    $params = [
                        ':asset_code' => $asset_code,
                        ':asset_name' => $asset_name,
                        ':purchase_date' => $purchase_date,
                        ':price' => $price,
                        ':image' => $filename,
                        ':asset_id' => $asset_id
                    ];

                } else {

                    $sql = "UPDATE assets SET
                            asset_code = :asset_code,
                            asset_name = :asset_name,
                            purchase_date = :purchase_date,
                            price = :price
                            WHERE asset_id = :asset_id";

                    $params = [
                        ':asset_code' => $asset_code,
                        ':asset_name' => $asset_name,
                        ':purchase_date' => $purchase_date,
                        ':price' => $price,
                        ':asset_id' => $asset_id
                    ];
                }

                $stmt = $conn->prepare($sql);
                $stmt->execute($params);

                responseJSON([
                    "success" => true,
                    "message" => "แก้ไขข้อมูลครุภัณฑ์สำเร็จ"
                ]);

                break;


            // =========================
            // DELETE : ลบครุภัณฑ์
            // =========================

            case 'delete':

                $asset_id = $_POST['asset_id'] ?? '';

                $stmt = $conn->prepare(
                    "DELETE FROM assets WHERE asset_id = :asset_id"
                );

                $stmt->execute([
                    ':asset_id' => $asset_id
                ]);

                responseJSON([
                    "success" => true,
                    "message" => "ลบข้อมูลครุภัณฑ์สำเร็จ"
                ]);

                break;


            default:

                responseJSON([
                    "success" => false,
                    "error" => "Action ไม่ถูกต้อง"
                ], 400);

        }

    } else {

        // =========================
        // GET : แสดงรายการครุภัณฑ์
        // =========================

        $stmt = $conn->prepare(
            "SELECT * FROM assets ORDER BY asset_id DESC"
        );

        $stmt->execute();

        $assets = $stmt->fetchAll(PDO::FETCH_ASSOC);

        responseJSON([
            "success" => true,
            "data" => $assets
        ]);

    }

} catch (Throwable $e) {

    error_log($e->getMessage());

    responseJSON([
        "success" => false,
        "error" => "เกิดข้อผิดพลาด: " . $e->getMessage()
    ], 500);

}

?>
