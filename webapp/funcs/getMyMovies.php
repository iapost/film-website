<?php
//POST params: token
//returns: json list of {
//							id:...,
//							title:...,
//							category:...,
//							startdate:...,
//							enddate:...,
//							owneremail:...
//						}
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
//Get movies from orion
$q=curl_init();
curl_setopt($q,CURLOPT_URL,'http://orion:1026/v2/entities?limit=1000&options=keyValues&q=owneremail=='.$email);
curl_setopt($q,CURLOPT_HTTPHEADER,array('Accept: application/json'));
curl_exec($q);
curl_close($q);
?>
