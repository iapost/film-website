<?php
//POST params: token, mid
//returns: OK or error message
if(!isset($_POST['token'])){
	echo('ERROR: no token given');
	exit();
}
if(!isset($_POST['mid'])){
	echo('ERROR: missing params');
	exit();
}
//Delete favorite from data server
$q=curl_init();
curl_setopt($q,CURLOPT_POST,true);
curl_setopt($q,CURLOPT_POSTFIELDS,array('token'=>$_POST['token'],'mid'=>$_POST['mid']));
curl_setopt($q,CURLOPT_URL,'http://data-server:80/del_fav/');
curl_setopt($q,CURLOPT_RETURNTRANSFER,true);
$subid=curl_exec($q);
if(strlen($subid)!=24){
	echo($subid);
	exit();
}
curl_close($q);
//Delete subscription from orion
$dq=curl_init();
curl_setopt($dq,CURLOPT_CUSTOMREQUEST,"DELETE");
curl_setopt($dq,CURLOPT_URL,'http://orion:1026/v2/subscriptions/'.$subid);
curl_exec($dq);
if(curl_getinfo($dq,CURLINFO_HTTP_CODE)==204){
	echo('OK');
}else{
	echo('ERROR: Orion error');
}
curl_close($dq);

?>