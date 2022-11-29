<?php
//POST params: token(of admin),userid(keyrock id)
//returns: OK or error message

if(!isset($_POST['token'])){
	echo('ERROR: no token given');
	exit();
}
if(!isset($_POST['userid'])){
	echo('ERROR: missing params');
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
//Get email of user to be deleted
$q=curl_init();
curl_setopt($q,CURLOPT_URL,'http://fiware-idm:3000/v1/users/'.$_POST['userid']);
curl_setopt($q,CURLOPT_HTTPHEADER,array('X-Auth-token: '.$authtoken));
curl_setopt($q, CURLOPT_RETURNTRANSFER,true);
$response=curl_exec($q);
if(curl_getinfo($q,CURLINFO_HTTP_CODE)!=200){
	echo('ERROR: '.$response);
	exit();
}
curl_close($q);
$decresponse=json_decode($response,true);
$email=$decresponse['user']['email'];
//Delete user from data server
$dq=curl_init();
curl_setopt($dq,CURLOPT_URL,'http://data-server:80/cleanup_user/');
curl_setopt($dq,CURLOPT_POST,true);
curl_setopt($dq,CURLOPT_POSTFIELDS,'token='.$_POST['token'].'&email='.$email);
curl_setopt($dq,CURLOPT_RETURNTRANSFER,true);
curl_setopt($dq,CURLOPT_HTTPHEADER,array('Content-Type: application/x-www-form-urlencoded'));
$subs=curl_exec($dq);
curl_close($dq);
if(substr($subs,0,6)=='ERROR:'){
	echo($subs);
	exit();
}
$subids=json_decode($subs,true);
//Delete favorites of user in orion
$delq=curl_init();
curl_setopt($delq,CURLOPT_CUSTOMREQUEST,"DELETE");
for($i=0; $i<count($subids); $i++){
	curl_setopt($delq,CURLOPT_URL,'http://orion:1026/v2/subscriptions/'.$subids[$i]['subid']);
	curl_exec($delq);
}
curl_close($delq);
//Delete user from keyrock
$q=curl_init();
curl_setopt($q,CURLOPT_URL,'http://fiware-idm:3000/v1/users/'.$_POST['userid']);
curl_setopt($q,CURLOPT_HTTPHEADER,array('X-Auth-token: '.$authtoken));
curl_setopt($q,CURLOPT_CUSTOMREQUEST,"DELETE");
curl_setopt($q, CURLOPT_RETURNTRANSFER,true);
$res=curl_exec($q);
if(curl_getinfo($q,CURLINFO_HTTP_CODE)!=204){
	echo('ERROR: while deleting user: '.$res);
	exit();
}
curl_close($q);
//Get all movies owned by deleted user (if he was a CINEMAOWNER)
$q=curl_init();
curl_setopt($q,CURLOPT_URL,"http://orion:1026/v2/entities/?q=owneremail=='".$email."'&options=keyValues");
curl_setopt($q, CURLOPT_RETURNTRANSFER,true);
$movies=json_decode(curl_exec($q),true);
curl_close($q);
//For each movie owned by the deleted user:
for($i=0; $i<count($movies); $i++){
	//Delete movie from all users' favorites and notifications in data server
	$dq=curl_init();
	curl_setopt($dq,CURLOPT_URL,'http://data-server:80/cleanup_movie/');
	curl_setopt($dq,CURLOPT_POST,true);
	curl_setopt($dq,CURLOPT_POSTFIELDS,'token='.$_POST['token'].'&mid='.$movies[$i]['id']);
	curl_setopt($dq,CURLOPT_RETURNTRANSFER,true);
	curl_setopt($dq,CURLOPT_HTTPHEADER,array('Content-Type: application/x-www-form-urlencoded'));
	$r=curl_exec($dq);
	curl_close($dq);
	if($r!='OK'){
		echo($r);
		exit();
	}
	//Get all subscriptions in orion
	$q=curl_init();
	curl_setopt($q,CURLOPT_URL,'http://orion:1026/v2/subscriptions');
	curl_setopt($q,CURLOPT_RETURNTRANSFER,true);
	$allsubs=json_decode(curl_exec($q),true);
	curl_close($q);
	//Delete all subscriptions for this movie from orion
	$delq=curl_init();
	curl_setopt($delq,CURLOPT_CUSTOMREQUEST,"DELETE");
	for($j=0; $j<count($allsubs); $j++){
		$var=$allsubs[$j]['subject']['entities'][0]['id'];
		if($var==$movies[$i]['id']){
			curl_setopt($delq,CURLOPT_URL,'http://orion:1026/v2/subscriptions/'.$allsubs[$j]['id']);
			curl_exec($delq);
		}
	}
	curl_close($delq);
	//Delete this movie from orion
	$q=curl_init();
	curl_setopt($q,CURLOPT_URL,'http://orion:1026/v2/entities/'.$movies[$i]['id']);
	curl_setopt($q,CURLOPT_CUSTOMREQUEST,"DELETE");
	curl_exec($q);
	if(curl_getinfo($q,CURLINFO_HTTP_CODE)!=204){
		echo('ERROR: Orion error');
	}
	curl_close($q);
}
echo('OK');
?>