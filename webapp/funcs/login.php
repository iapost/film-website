<?php 
//POST params: email,password
//returns: token or 'ERROR'
if (isset($_POST['email']) && isset($_POST['password'])){
	$cq=curl_init();
	curl_setopt($cq,CURLOPT_URL,'http://fiware-idm:3000/oauth2/token');
	curl_setopt($cq,CURLOPT_POST,true);
	curl_setopt($cq,CURLOPT_POSTFIELDS,'grant_type=password&username='.$_POST['email'].'&password='.$_POST['password']);
	$headers = array(
		'Accept: application/json',
	    'Authorization: Basic YmNmNTIxNjItNzEyMC00N2QyLTg5MzQtYzg4NjU1MGU4NjUyOjYzNzA3ZTkyLWM4NmQtNGUwMC04ZDhlLTMxODdkNWZhMTZiZA==',
	    'Content-Type: application/x-www-form-urlencoded',
	);
	curl_setopt($cq, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($cq, CURLOPT_RETURNTRANSFER,true);
	$response=curl_exec($cq);
	curl_close($cq);
	if($response==false){
		echo('ERROR');
		exit();
	}else{
		$res=json_decode($response,true);
		if(!isset($res['access_token'])){
			echo('ERROR');
			exit();
		}
	}
}
//Check that user has a valid role in application
$q=curl_init();
curl_setopt($q,CURLOPT_URL,'http://fiware-idm:3000/user?access_token='.$res['access_token']);
curl_setopt($q,CURLOPT_RETURNTRANSFER,true);
$response=curl_exec($q);
curl_close($q);
if($response==false){
	echo('ERROR');
}else{
	$resp=json_decode($response,true);
	if(!isset($resp['roles'][0]['name'])){
		echo('ERROR');
		exit();
	}
	$role=$resp['roles'][0]['name'];
	if($role!='ADMIN'&&$role!='CINEMAOWNER'&&$role!='USER'){
		echo('ERROR');
		exit();
	}
}
echo($res['access_token']);
?>