<?php
//POST params: token(of admin),userid(keyrock id),username,name,surname
//returns: OK or error message

if(!isset($_POST['token'])){
	echo('ERROR: no token given');
	exit();
}
if(!isset($_POST['userid'])||!isset($_POST['username'])||!isset($_POST['name'])||!isset($_POST['surname'])){
	echo('ERROR: missing params');
	exit();
}
//Get admin token for keyrock
$pq=curl_init();
curl_setopt($pq,CURLOPT_URL,'localhost:80/funcs/getAdminToken.php');
curl_setopt($pq,CURLOPT_POST,true);
curl_setopt($pq,CURLOPT_POSTFIELDS,'token='.$_POST['token']);
curl_setopt($pq,CURLOPT_RETURNTRANSFER,true);
curl_setopt($pq,CURLOPT_HTTPHEADER,array('Content-Type: application/x-www-form-urlencoded'));
$authtoken=curl_exec($pq);
curl_close($pq);
if(substr($authtoken,0,6)=='ERROR:'){
	echo($authtoken);
	exit();
}
//Get email of user
$eq=curl_init();
curl_setopt($eq,CURLOPT_URL,'http://fiware-idm:3000/v1/users/'.$_POST['userid']);
curl_setopt($eq,CURLOPT_RETURNTRANSFER,true);
curl_setopt($eq,CURLOPT_HTTPHEADER,array('X-Auth-token: '.$authtoken));
$res=json_decode(curl_exec($eq),true);
$email=$res['user']['email'];
curl_close($eq);
//Update username in keyrock if necessary
if($res['user']['username']!=$_POST['username']){
	$q=curl_init();
	curl_setopt($q,CURLOPT_URL,'http://fiware-idm:3000/v1/users/'.$_POST['userid']);
	curl_setopt($q,CURLOPT_CUSTOMREQUEST,"PATCH");
	curl_setopt($q,CURLOPT_POSTFIELDS,json_encode(array('user'=>array('username'=>$_POST['username']))));
	curl_setopt($q,CURLOPT_RETURNTRANSFER,true);
	curl_setopt($q,CURLOPT_HTTPHEADER,array('Content-Type: application/json','X-Auth-token: '.$authtoken));
	$ures=json_decode(curl_exec($q),true);
	curl_close($q);
	if(!isset($ures['values_updated'])){
		echo('ERROR: keyrock error');
		exit();
	}
}
//Update name and surname in data server
$dq=curl_init();
curl_setopt($dq,CURLOPT_URL,'data-server:80/update_user/');
curl_setopt($dq,CURLOPT_POST,true);
curl_setopt($dq,CURLOPT_POSTFIELDS,'token='.$_POST['token'].'&email='.$email.'&name='.$_POST['name'].'&surname='.$_POST['surname']);
curl_setopt($dq,CURLOPT_HTTPHEADER,array('Content-Type: application/x-www-form-urlencoded'));
curl_exec($dq);
curl_close($dq);
?>