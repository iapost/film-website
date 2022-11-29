<?php
//POST params: token,email
//returns OK or error message
if(!isset($_POST['token'])){
	echo('ERROR: no token given');
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
if(!isset($_POST['email'])){
	echo("ERROR: missing params");
	exit();
}
//Enable user in data server
$q=curl_init();
curl_setopt($q,CURLOPT_URL,'http://data-server:80/enable_user/');
curl_setopt($q,CURLOPT_POST,true);
curl_setopt($q,CURLOPT_POSTFIELDS,'token='.$_POST['token'].'&email='.$_POST['email']);
curl_setopt($q,CURLOPT_RETURNTRANSFER,true);
curl_setopt($q,CURLOPT_HTTPHEADER,array('Content-Type: application/x-www-form-urlencoded'));
$res=curl_exec($q);
curl_close($q);
if(substr($res,0,6)=='ERROR:'){
	echo($res);
	exit();
}
$info=json_decode($res,true);
//Create user in keyrock
$cq=curl_init();
curl_setopt($cq,CURLOPT_URL,'http://fiware-idm:3000/v1/users');
curl_setopt($cq,CURLOPT_POST,true);
curl_setopt($cq,CURLOPT_POSTFIELDS,json_encode(array("user"=>array("username"=>$info['username'],"email"=>$_POST['email'],"password"=>$info['password']))));
curl_setopt($cq,CURLOPT_RETURNTRANSFER,true);
curl_setopt($cq,CURLOPT_HTTPHEADER,array('Content-Type: application/json','X-Auth-token: '.$authtoken));
$res=curl_exec($cq);
if(curl_getinfo($cq,CURLINFO_HTTP_CODE)!=201){
	echo('ERROR: could not create user');
	exit();
}
curl_close($cq);
$res=json_decode($res,true);
$usrid=$res['user']['id'];
//Assign role to user in keyrock
$url='http://fiware-idm:3000/v1/applications/bcf52162-7120-47d2-8934-c886550e8652/users/'.$usrid.'/roles/';
if($info['role']=='ADMIN'){
	$url=$url.'8cb2781c-17a5-4a12-8ec1-b6a065ed85fd';
}else if($info['role']=='CINEMAOWNER'){
	$url=$url.'c954a7f5-a4a4-4b3c-b048-227ed0f6aace';
}else{
	$url=$url.'12ab3051-f54a-49ba-afb1-461564987bce';
}
$rq=curl_init();
curl_setopt($rq,CURLOPT_URL,$url);
curl_setopt($rq,CURLOPT_POST,true);
curl_setopt($rq,CURLOPT_RETURNTRANSFER,true);
curl_setopt($rq,CURLOPT_HTTPHEADER,array('Content-Type: application/json','X-Auth-Token: '.$authtoken));
$res=curl_exec($rq);
if(curl_getinfo($rq,CURLINFO_HTTP_CODE)!=201){
	echo('ERROR: could not assign role to user');
	exit();
}
curl_close($rq);
echo('OK');
?>