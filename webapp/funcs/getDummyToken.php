<?php 
//returns: token or ERROR
$cq=curl_init();
curl_setopt($cq,CURLOPT_URL,'http://fiware-idm:3000/oauth2/token');
curl_setopt($cq,CURLOPT_POST,true);
curl_setopt($cq,CURLOPT_POSTFIELDS,'grant_type=password&username=dummy@mail.com&password=dummy');
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
}else{
	$res=json_decode($response,true);
	if(!isset($res['access_token'])){
		echo('ERROR');
	}else{
		echo($res['access_token']);
	}
}
?>