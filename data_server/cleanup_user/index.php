<?php
//POST params: token(of admin),email
//returns: error message or json list of favorites {
//													"mid":...,
//													"subid":...
//													}

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
	echo('ERROR: missing params');
	exit();
}
$m=new MongoDB\Client("mongodb://mongo-data:27017");
$db=$m->film_project;
$db->cinemas->findOneAndDelete(array('email'=>$_POST['email']));
$user=$db->users->findOneAndDelete(array('email'=>$_POST['email']));
if(is_null($user)){
	echo('ERROR: user not found');
	exit();
}
echo(json_encode($user['favorites']));
?>