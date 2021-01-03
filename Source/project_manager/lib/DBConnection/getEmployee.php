<?php
require('connect.php');

$query = "SELECT * FROM Employee";

$statement = $connection->prepare($query);
$statement->execute();

$myArray = array();
while ($result = $statement->fetch()){
    array_push(
        $myArray,array(
            "EID"=>$result['EID'],
            "userName"=>$result['userName'],
            "role"=>$result['role']
            )
        );
    }
    
echo json_encode($myArray)
?>