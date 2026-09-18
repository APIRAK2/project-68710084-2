<?php

header('Content-Type: application/json; charset=utf-8');

include 'condb.php';

$data = json_decode(file_get_contents("php://input"), true);

// ตรวจสอบข้อมูลที่จำเป็น
if (
    !isset($data['subject']) ||
    !isset($data['detail']) ||
    !isset($data['fullname']) ||
    !isset($data['email'])
) {
    echo json_encode([
        "success" => false,
        "message" => "ข้อมูลไม่ครบ"
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

try {

    $sql = "INSERT INTO contacts
            (subject, detail, fullname, email)
            VALUES
            (:subject, :detail, :fullname, :email)";

    $stmt = $conn->prepare($sql);

    $stmt->execute([
        ':subject'  => $data['subject'],
        ':detail'   => $data['detail'],
        ':fullname' => $data['fullname'],
        ':email'    => $data['email']
    ]);

    echo json_encode([
        "success" => true,
        "message" => "เพิ่มข้อมูลเรียบร้อย",
        "contact_id" => $conn->lastInsertId()
    ], JSON_UNESCAPED_UNICODE);

} catch (PDOException $e) {

    echo json_encode([
        "success" => false,
        "message" => "เกิดข้อผิดพลาดในการบันทึกข้อมูล"
    ], JSON_UNESCAPED_UNICODE);
}
