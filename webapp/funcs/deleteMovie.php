<?php
//POST params: token,mid
//returns OK if successful or error message

if(isset($_POST['token'])){
	$cq=curl_init();
	curl_setopt($cq,CURLOPT_URL,'http://fiware-idm:3000/user?access_token='.$_POST['token']);
	curl_setopt($cq, CURLOPT_RETURNTRANSFER,true);
	$response=curl_exec($cq);
	curl_close($cq);
	if($response==false){
		echo('ERROR: could not validate token');
		exit();
	}else{
		$res=json_decode($response,true);
		if(!isset($res['roles'][0]['name'])||$res['roles'][0]['name']!='CINEMAOWNER'){
			echo('ERROR: invalid token or role');
			exit();
		}
		$email=$res['email'];
	}
}else{
	echo('ERROR: no token given');
	exit();
}
if(!isset($_POST['mid'])){
	echo('ERROR: missing params');
	exit();
}
//Check if user is owner of the movie
$q=curl_init();
curl_setopt($q,CURLOPT_URL,'http://orion:1026/v2/entities/'.$_POST['mid'].'?options=keyValues');
curl_setopt($q,CURLOPT_RETURNTRANSFER,true);
$res=json_decode(curl_exec($q),true);
curl_close($q);
if($res['owneremail']!=$email){
	echo('ERROR: user is not owner of movie');
	exit();
}
//Delete movie from all users' favorites and notifications in data server
$dq=curl_init();
curl_setopt($dq,CURLOPT_URL,'http://data-server:80/cleanup_movie/');
curl_setopt($dq,CURLOPT_POST,true);
curl_setopt($dq,CURLOPT_POSTFIELDS,'token='.$_POST['token'].'&mid='.$_POST['mid']);
curl_setopt($dq,CURLOPT_RETURNTRANSFER,true);
curl_setopt($dq,CURLOPT_HTTPHEADER,array('Content-Type: application/x-www-form-urlencoded'));
$r=curl_exec($dq);
curl_close($dq);
if($r!='OK'){
	echo($r);
	exit();
}
//Get all subscriptions from orion
$q=curl_init();
curl_setopt($q,CURLOPT_URL,'http://orion:1026/v2/subscriptions');
curl_setopt($q,CURLOPT_RETURNTRANSFER,true);
$allsubs=json_decode(curl_exec($q),true);
curl_close($q);
//Delete all subscriptions in orion for the movie that will be deleted
$delq=curl_init();
curl_setopt($delq,CURLOPT_CUSTOMREQUEST,"DELETE");
for($i=0; $i<count($allsubs); $i++){
	$var=$allsubs[$i]['subject']['entities'][0]['id'];
	if($var==$_POST['mid']){
		curl_setopt($delq,CURLOPT_URL,'http://orion:1026/v2/subscriptions/'.$allsubs[$i]['id']);
		curl_exec($delq);
	}
}
curl_close($delq);
//Delete movie from orion
$q=curl_init();
curl_setopt($q,CURLOPT_URL,'http://orion:1026/v2/entities/'.$_POST['mid']);
curl_setopt($q,CURLOPT_CUSTOMREQUEST,"DELETE");
curl_exec($q);
if(curl_getinfo($q,CURLINFO_HTTP_CODE)==204){
	echo('OK');
}else{
	echo('ERROR: Orion error');
}
curl_close($q);
?>