<?php
class Flat {
    private $flat_id, $owner_id, $reference_number, $location, $address, $price, $available_from, $available_to,
            $bedrooms, $bathrooms, $size_sqm, $conditions,
            $heating, $air_conditioning, $access_control,
            $parking, $backyard, $playground, $storage, $approved;

    public function __construct($flat_id, $owner_id, $reference_number, $location, $address, $price, $available_from, $available_to,
                                $bedrooms, $bathrooms, $size_sqm, $conditions,
                                $heating, $air_conditioning, $access_control,
                                $parking, $backyard, $playground, $storage, $approved) {
        $this->flat_id = $flat_id;
        $this->owner_id = $owner_id;
        $this->reference_number = $reference_number;
        $this->location = $location;
        $this->address = $address;
        $this->price = $price;
        $this->available_from = $available_from;
        $this->available_to = $available_to;
        $this->bedrooms = $bedrooms;
        $this->bathrooms = $bathrooms;
        $this->size_sqm = $size_sqm;
        $this->conditions = $conditions;
        $this->heating = $heating;
        $this->air_conditioning = $air_conditioning;
        $this->access_control = $access_control;
        $this->parking = $parking;
        $this->backyard = $backyard;
        $this->playground = $playground;
        $this->storage = $storage;
        $this->approved = $approved;
    }
// this method looks for the flats that are not rented . the query contains that the is_rented value should be 0
  public static function searchFlats($pdo, $price, $location, $bedrooms, $bathrooms, $furnished) {
    $sql = "SELECT * FROM flats WHERE is_rented = 0";
    $params = [];
    if (!empty($price)) {
        $sql .= " AND price <= :price";
        $params[':price'] = $price;
    }
    if (!empty($location)) {
        $sql .= " AND location LIKE :location";
        $params[':location'] = "%$location%";
    }
    if (!empty($bedrooms)) {
        $sql .= " AND bedrooms = :bedrooms";
        $params[':bedrooms'] = $bedrooms;
    }
    if (!empty($bathrooms)) {
        $sql .= " AND bathrooms = :bathrooms";
        $params[':bathrooms'] = $bathrooms;
    }
    if ($furnished === 'yes') {
        $sql .= " AND furnished = 1";
    } elseif ($furnished === 'no') {
        $sql .= " AND furnished = 0";
    }

    $sql .= " AND flat_id NOT IN (SELECT flat_id FROM rentals WHERE end_date >= CURDATE())";

    $sql .= " ORDER BY price ASC";

    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);

    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

public static function getFlatByReference($pdo, $reference) {
$stmt = $pdo->prepare("SELECT f.flat_id, f.owner_id, f.reference_number, f.location, f.address, f.price AS rent, 
                              f.available_from, f.available_to, f.bedrooms, f.bathrooms, f.size_sqm, f.conditions, 
                              f.heating, f.air_conditioning, f.access_control, f.parking, f.backyard, f.playground, 
                              f.storage,f.is_rented, u.name AS owner_name, u.mobile AS owner_phone
                       FROM flats f
                       JOIN users u ON f.owner_id = u.user_id
                       WHERE f.reference_number = :ref");

    $stmt->execute([':ref' => $reference]);
    $flat = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$flat) return null;

    // Load photos
    $stmt2 = $pdo->prepare("SELECT image_path FROM flat_photos WHERE flat_id = :flat_id");
    $stmt2->execute([':flat_id' => $flat['flat_id']]);
    $flat['photos'] = $stmt2->fetchAll(PDO::FETCH_COLUMN);

    // Load marketing info from the marketing_info
    $stmt3 = $pdo->prepare("SELECT title, description AS `desc`, url FROM marketing_info WHERE flat_id = :flat_id");
    $stmt3->execute([':flat_id' => $flat['flat_id']]);
    $flat['marketing'] = $stmt3->fetchAll(PDO::FETCH_ASSOC);

    return $flat;
}



    public static function getFlatIdByReference($pdo, $ref) {
        $stmt = $pdo->prepare("SELECT flat_id FROM flats WHERE reference_number = :ref");
        $stmt->execute([':ref' => $ref]);
        $row = $stmt->fetch();
        return $row ? $row['flat_id'] : null;
    }
}
?>
