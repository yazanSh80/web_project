<?php
class FlatPhoto {
    private $photo_id, $flat_id, $image_path;

    public function __construct($photo_id, $flat_id, $image_path) {
        $this->photo_id = $photo_id;
        $this->flat_id = $flat_id;
        $this->image_path = $image_path;
    }
}
?>
