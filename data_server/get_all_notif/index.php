<?php
//POST params: token
//returns: json list of relevant notifications {
//												title:...,
//												owneremail:...,
//												startdate:...,
//												enddate:...,
//											   }

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

$m=new MongoDB\Client("mongodb://mongo-data:27017");
$coll=$m->film_project->users;
$res=$coll->findOne(array('email'=>$email),array('projection'=>array('favorites'=>0)));
$n=$res['notifications'];
$d=date("Y-m-d");
for($i=0; $i<count($n); $i++){
	unset($n[$i]['id']);
	if(strcmp($n[$i]['startdate'],$d)>0){
		unset($n[$i]);
	}
}
echo(json_encode($n));
