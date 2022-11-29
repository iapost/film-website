<?php
//POST params: token,email
//returns: OK or error message

if(!isset($_POST['token'])){
	echo('ERROR: no token given');
	exit();
}
if(!isset($_POST['email'])){
	echo('ERROR: missing params');
	exit();
}
//Forward request to data server
$q=curl_init();
curl_setopt($q,CURLOPT_URL,'http://data-server:80/delete_new_user/');
curl_setopt($q,CURLOPT_HTTPHEADER,array('Content-Type: application/x-www-form-urlencoded'));
curl_setopt($q,CURLOPT_POST,true);
curl_setopt($q,CURLOPT_POSTFIELDS,'token='.$_POST['token'].'&email='.$_POST['email']);
curl_exec($q);
curl_close($q);

?>