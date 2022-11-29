<?php
//POST params: token
//returns: X-Auth-Token from keyrock

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
		if(!isset($res['roles'][0]['name'])||$res['roles'][0]['name']!='ADMIN'){
			echo('ERROR: invalid token or role');
			exit();
		}
	}
}else{
	echo('ERROR: no token given');
	exit();
}

$q=curl_init();
curl_setopt($q,CURLOPT_URL,'http://fiware-idm:3000/v1/auth/tokens');
curl_setopt($q,CURLOPT_HTTPHEADER,array('Content-Type: application/json'));
curl_setopt($q,CURLOPT_POST,true);
curl_setopt($q,CURLOPT_POSTFIELDS,json_encode(array('name'=>'superadmin@mail.com','password'=>'admin1234')));
curl_setopt($q,CURLOPT_RETURNTRANSFER,true);
curl_setopt($q,CURLOPT_HEADER,true);
$res=curl_exec($q);
if(curl_getinfo($q,CURLINFO_HTTP_CODE)!=201){
	echo('ERROR: could not communicate with keyrock');
	exit();
}
$hsize=curl_getinfo($q,CURLINFO_HEADER_SIZE);
curl_close($q);
$headers=substr($res,0,$hsize);
$harr=explode("\r\n",$headers);
for($i=0; $i<count($harr); $i++){
	if(substr($harr[$i],0,15)=='X-Subject-Token'){
		echo(ltrim(substr($harr[$i],16)));
		exit();
	}
}


