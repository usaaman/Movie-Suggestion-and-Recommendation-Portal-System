<?php
require_once('../config.php');

class Master extends DBConnection {
    private $settings;

    public function __construct() {
        global $_settings;
        $this->settings = $_settings;
        parent::__construct();
    }

    public function __destruct() {
        parent::__destruct();
    }

    private function capture_err() {
        if (!$this->conn->error) return false;
        $resp = [
            'status' => 'failed',
            'error' => $this->conn->error
        ];
        echo json_encode($resp);
        exit;
    }

    private function build_query($table, $data, $id = null) {
        $sql = "";
        $fields = [];
        foreach ($data as $key => $value) {
            $value = $this->conn->real_escape_string($value);
            $fields[] = "`$key` = '$value'";
        }
        if ($id) {
            $sql = "UPDATE `$table` SET " . implode(", ", $fields) . " WHERE id = '$id'";
        } else {
            $sql = "INSERT INTO `$table` SET " . implode(", ", $fields);
        }
        return $sql;
    }

    private function execute_query($sql) {
        $result = $this->conn->query($sql);
        if ($result) {
            return true;
        } else {
            $this->capture_err();
            return false;
        }
    }

    private function handle_file_upload($file, $path) {
        if ($file['tmp_name'] != '') {
            $allowed = ['image/png', 'image/jpeg'];
            $type = mime_content_type($file['tmp_name']);
            if (!in_array($type, $allowed)) {
                return "Invalid file type.";
            }

            list($width, $height) = getimagesize($file['tmp_name']);
            $new_width = 260;
            $new_height = 385;

            $image = imagecreatetruecolor($new_width, $new_height);
            imagealphablending($image, false);
            imagesavealpha($image, true);

            $source_image = ($type === 'image/png') 
                ? imagecreatefrompng($file['tmp_name']) 
                : imagecreatefromjpeg($file['tmp_name']);

            imagecopyresampled($image, $source_image, 0, 0, 0, 0, $new_width, $new_height, $width, $height);

            if ($source_image) {
                if (is_file($path)) unlink($path);
                imagepng($image, $path);
                imagedestroy($source_image);
                imagedestroy($image);
                return true;
            } else {
                return "Failed to process the image.";
            }
        }
        return false;
    }

    public function save_message() {
        $data = $_POST;
        $id = $data['id'] ?? null;
        unset($data['id']);

        $sql = $this->build_query('message_list', $data, $id);
        $status = $this->execute_query($sql);
        if ($status) {
            $msg = $id ? "Message updated successfully." : "Message sent successfully.";
            $this->settings->set_flashdata('success', $msg);
            return json_encode(['status' => 'success', 'msg' => $msg]);
        }
    }

    public function delete_message() {
        extract($_POST);
        $id = $this->conn->real_escape_string($id);
        $sql = "DELETE FROM `message_list` WHERE id = '$id'";
        if ($this->execute_query($sql)) {
            $this->settings->set_flashdata('success', "Message deleted successfully.");
            return json_encode(['status' => 'success']);
        }
    }

    public function save_genre() {
        $data = $_POST;
        $id = $data['id'] ?? null;
        unset($data['id']);

        $name = $this->conn->real_escape_string($data['name']);
        $check = $this->conn->query("SELECT * FROM `genre_list` WHERE `name` = '$name'" . ($id ? " AND id != '$id'" : ""))->num_rows;

        if ($check > 0) {
            return json_encode(['status' => 'failed', 'msg' => 'Genre already exists.']);
        }

        $sql = $this->build_query('genre_list', $data, $id);
        $status = $this->execute_query($sql);
        if ($status) {
            $msg = $id ? "Genre updated successfully." : "Genre added successfully.";
            $this->settings->set_flashdata('success', $msg);
            return json_encode(['status' => 'success', 'msg' => $msg]);
        }
    }

    public function delete_genre() {
        extract($_POST);
        $id = $this->conn->real_escape_string($id);
        $sql = "DELETE FROM `genre_list` WHERE id = '$id'";
        if ($this->execute_query($sql)) {
            $this->settings->set_flashdata('success', "Genre deleted successfully.");
            return json_encode(['status' => 'success']);
        }
    }

    // Repeat similar fixes for `save_movie`, `delete_movie`, `save_review`, and other functions.

    public function save_movie() {
        if (isset($_POST['genre_arr'])) {
            $_POST['genres'] = implode(",", $_POST['genre_arr']);
            unset($_POST['genre_arr']);
        }

        $data = $_POST;
        $id = $data['id'] ?? null;
        unset($data['id']);

        $sql = $this->build_query('movie_list', $data, $id);
        $status = $this->execute_query($sql);

        if ($status) {
            $msg = $id ? "Movie updated successfully." : "Movie added successfully.";
            $mid = $id ? $id : $this->conn->insert_id;

            if (isset($_FILES['img'])) {
                $upload_result = $this->handle_file_upload($_FILES['img'], base_app . "uploads/movie-$mid.png");
                if ($upload_result === true) {
                    $this->conn->query("UPDATE movie_list SET `image_path` = 'uploads/movie-$mid.png' WHERE id = '$mid'");
                }
            }

            $this->settings->set_flashdata('success', $msg);
            return json_encode(['status' => 'success', 'msg' => $msg]);
        }
    }
}

$Master = new Master();
$action = $_GET['f'] ?? 'none';

switch (strtolower($action)) {
    case 'save_message': echo $Master->save_message(); break;
    case 'delete_message': echo $Master->delete_message(); break;
    case 'save_genre': echo $Master->save_genre(); break;
    case 'delete_genre': echo $Master->delete_genre(); break;
    case 'save_movie': echo $Master->save_movie(); break;
    // Other cases.
    default: break;
}
