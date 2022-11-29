<?php 
//POST params: username,password,name,surname,email,role
//returns OK or error message

if(!isset($_POST['username'])||!isset($_POST['password'])||!isset($_POST['name'])||!isset($_POST['surname'])||!isset($_POST['email'])||!isset($_POST['role'])){
	echo("ERROR: missing params");
	exit();
}
//Get dummy token to bypass PEP Proxy for Data Server
$tq=curl_init();
curl_setopt($tq,CURLOPT_URL,'localhost:80/funcs/getDummyToken.php');
curl_setopt($tq,CURLOPT_RETURNTRANSFER,true);
$token=curl_exec($tq);
curl_close($tq);
//Store new user's info in data server waiting an admin's approval
$data='username='.$_POST['username'].'&password='.$_POST['password'].'&name='.$_POST['name'].'&surname='.$_POST['surname'].'&email='.$_POST['email'].'&role='.$_POST['role'];
$q=curl_init();
curl_setopt($q,CURLOPT_URL,'http://data-server:80/create_user/');
curl_setopt($q,CURLOPT_HTTPHEADER,array('Content-Type: application/x-www-form-urlencoded'));
curl_setopt($q,CURLOPT_POST,true);
curl_setopt($q,CURLOPT_POSTFIELDS,$data);
curl_exec($q);
curl_close($q);
?>