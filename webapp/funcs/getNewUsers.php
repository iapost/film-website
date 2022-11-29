<?php
//POST params: token
//returns json list of {email,username,name,surname,role} or error message

if(!isset($_POST['token'])){
	echo('ERROR: no token given');
	exit();
}
//Forward request to data server
$q=curl_init();
curl_setopt($q,CURLOPT_URL,'http://data-server:80/get_new_users/');
curl_setopt($q,CURLOPT_HTTPHEADER,array('Content-Type: application/x-www-form-urlencoded'));
curl_setopt($q,CURLOPT_POST,true);
curl_setopt($q,CURLOPT_POSTFIELDS,'token='.$_POST['token']);
curl_exec($q);
curl_close($q);
?>