<?php
//POST params: token,email
//returns json {username,password,role} or error message

require '../vendor/autoload.php';

if(isset($_POST['token'])){
	$cq=curl_init();
	curl_setopt($cq,CURLOPT_URL,'http://fiware-idm:3000/user?access_token='.$_POST['token']);
	curl_setopt($cq, CURLOPT_RETURNTRANSFER,true);
	$response=curl_exec($cq);
	curl_close($cq);
	if($response==false){
		echo('ERROR: could not validate token');
		exit();
	}else{
		$res=json_decode($response,true);
		if(!isset($res['roles'][0]['name'])||$res['roles'][0]['name']!='ADMIN'){
			echo('ERROR: invalid token or role');
			exit();
		}
	}
}else{
	echo('ERROR: no token given');
	exit();
}
if(!isset($_POST['email'])){
	echo("ERROR: missing params");
	exit();
}
$m=new MongoDB\Client("mongodb://mongo-data:27017");
$coll=$m->film_project->newUsers;
$newuser=$coll->findOneAndDelete(array("email"=>$_POST['email']));
if(is_null($newuser)){
	echo('ERROR: user not found');
	exit();
}
$coll=$m->film_project->users;
$coll->insertOne(array("email"=>$_POST['email'],"name"=>$newuser['name'],"surname"=>$newuser['surname'],"notifications"=>array(),"favorites"=>array()));
if($newuser['role']=='CINEMAOWNER'){
	$coll=$m->film_project->cinemas;
	$coll->insertOne(array("email"=>$_POST['email'],"name"=>""));
}
$result=array('username'=>$newuser['username'],'password'=>$newuser['password'],'role'=>$newuser['role']);
echo(json_encode($result));
?>