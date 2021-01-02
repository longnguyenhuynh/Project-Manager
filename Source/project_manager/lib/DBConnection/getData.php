<?php
require('connect.php');
$query = "SELECT * FROM loginInfo";
$statement = $connection->prepare($query);
$statement->execute();

$myArray = array();

while($result = $statement->fetch()){
    array_push(
        $myArray,array(
                "id"=>$result['id'],
                "username"=>$result['username'],
                "password"=>$result['password']
            )
        );
}


?>