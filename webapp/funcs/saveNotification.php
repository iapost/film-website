<?php
//GET params: email
//POST body: json notification
if(!isset($_GET['email'])){
	exit();
}
$data=file_get_contents('php://input');
//Get dummy token to bypass PEP Proxy
$tq=curl_init();
curl_setopt($tq,CURLOPT_URL,'localhost:80/funcs/getDummyToken.php');
curl_setopt($tq,CURLOPT_RETURNTRANSFER,true);
$token=curl_exec($tq);
curl_close($tq);
//Forward notification to data server
$q=curl_init();
curl_setopt($q,CURLOPT_URL,'http://data-server:80/add_notif/?email='.$_GET['email']);
curl_setopt($q,CURLOPT_POST,true);
curl_setopt($q,CURLOPT_POSTFIELDS,$data);
curl_exec($q);
curl_close($q);
?>