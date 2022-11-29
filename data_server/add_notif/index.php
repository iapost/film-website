1<?php
//GET params: email
//POST body: json notification
require '../vendor/autoload.php';

if(!isset($_GET['email'])){
	exit();
}
$data=json_decode(file_get_contents('php://input'),true);
$mid=$data['data'][0]['id'];
unset($data['data'][0]['type']);
$m=new MongoDB\Client("mongodb://mongo-data:27017");
$coll=$m->film_project->users;
$coll->updateOne(array('email'=>$_GET['email']),array('$pull'=>array('notifications'=>array('id'=>$mid))));
$coll->updateOne(array('email'=>$_GET['email']),array('$push'=>array('notifications'=>$data['data'][0])));
?>