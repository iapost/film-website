<?php
//POST params: token
//returns json list of {email,name,surname} or error message

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
$m=new MongoDB\Client("mongodb://mongo-data:27017");
$coll=$m->film_project->users;
$res=$coll->find(array(),array("projection"=>array("_id"=>0,"notifications"=>0,"favorites"=>0)))->toArray();
echo(json_encode($res));
?>