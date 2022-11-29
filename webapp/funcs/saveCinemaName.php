<?php
//POST params: token,name
//returns: OK

if(!isset($_POST['token'])){
	echo('ERROR: no token given');
	exit();
}
if(!isset($_POST['name'])){
	echo('ERROR: missing params');
	exit();
}
//Forward request to data server
$q=curl_init();
curl_setopt($q,CURLOPT_POST,true);
curl_setopt($q,CURLOPT_POSTFIELDS,array('token'=>$_POST['token'],'name'=>$_POST['name']));
curl_setopt($q,CURLOPT_URL,'http://data-server:80/save_cin_name/');
curl_exec($q);
curl_close($q);
?>