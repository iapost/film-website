<?php
//POST params: username,password,name,surname,email,role
//returns OK or error message

require '../vendor/autoload.php';

if(!isset($_POST['username'])||!isset($_POST['password'])||!isset($_POST['name'])||!isset($_POST['surname'])||!isset($_POST['email'])||!isset($_POST['role'])){
	echo("ERROR: missing params");
	exit();
}
$m=new MongoDB\Client("mongodb://mongo-data:27017");
$coll=$m->film_project->users;
$res=$coll->findOne(array("email"=>$_POST['email']));
if(!is_null($res)){
	echo('ERROR:E-mail is already in use');
	exit();
}
$coll=$m->film_project->newUsers;
$res=$coll->findOne(array("email"=>$_POST['email']));
if(!is_null($res)){
	echo('ERROR:E-mail is already in use');
	exit();
}
$newuser=array(
	"email"=>$_POST['email'],
	"password"=>$_POST['password'],
	"username"=>$_POST['username'],
	"name"=>$_POST['name'],
	"surname"=>$_POST['surname'],
	"role"=>$_POST['role']
);
$coll->insertOne($newuser);
echo('OK');
?>