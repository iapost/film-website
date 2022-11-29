<?php
//GET params: name
//returns: email of owner or 204 response code if not found
require '../vendor/autoload.php';

if(!isset($_GET['name'])){
	http_response_code(204);
	exit;
}

$m=new MongoDB\Client("mongodb://mongo-data:27017");
$coll=$m->film_project->cinemas;
$doc=$coll->findOne(array('name'=>$_GET['name']));
if(is_null($doc)){
	http_response_code(204);
}else{
	echo($doc['email']);
}