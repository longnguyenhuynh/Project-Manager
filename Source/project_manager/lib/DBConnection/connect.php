<?php
try{
    $connection = new PDO('mysql:host=localhost,dbname=id15709883_database','id15709883_phuidatabase','Th1$1$pa$$word');
    $connection ->setAtribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
    echo("Connected");
}catch(PDOException $exc){
    echo $exp->getMessage();
    die("Can't Connect");
}
?>