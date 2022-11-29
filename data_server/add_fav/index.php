<?php
//POST params: token,mid,subid
//returns: OK or error message
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
		if(!isset($res['roles'][0]['name'])){
			echo('ERROR: invalid token');
			exit();
		}
		$email=$res['email'];
	}
}else{
	echo('ERROR: no token given');
	exit();
}
if(!isset($_POST['mid'])||!isset($_POST['subid'])){
	echo('ERROR: missing params');
	exit();
}
$m=new MongoDB\Client("mongodb://mongo-data:27017");
$coll=$m->film_project->users;
$coll->updateOne(array('email'=>$email),array('$push'=>array('favorites'=>array('mid'=>$_POST['mid'],'subid'=>$_POST['subid']))));
echo('OK');