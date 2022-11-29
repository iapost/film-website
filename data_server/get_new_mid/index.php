<?php
//params:
//returns: id to be used 
require '../vendor/autoload.php';

$m=new MongoDB\Client("mongodb://mongo-data:27017");
$coll=$m->film_project->count;
$id=$coll->findOne();
echo($id['id']);
$coll->updateOne(array('id'=>$id['id']),array('$set'=>array('id'=>$id['id']+1)));
?>