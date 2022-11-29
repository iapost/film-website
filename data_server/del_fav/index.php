<?php
//POST params: token,mid
//returns: subscription id of removed favorite

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
if(!isset($_POST['mid'])){
	echo('ERROR: missing params');
	exit();
}

$m=new MongoDB\Client("mongodb://mongo-data:27017");
$coll=$m->film_project->users;
$user=$coll->findOne(array('email'=>$email));
foreach($user['favorites'] as $value){
	if($value['mid']==$_POST['mid']){
		$subid=$value['subid'];
		echo($subid);
		break;
	}
}
$coll->updateOne(array('email'=>$email),array('$pull'=>array('favorites'=>array('mid'=>$_POST['mid']))));
$coll->updateOne(array('email'=>$email),array('$pull'=>array('notifications'=>array('id'=>$_POST['mid']))));
?>