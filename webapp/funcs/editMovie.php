<?php
//POST params: token,mid,title,category,startdate,enddate
//returns: OK or error message

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
	}
}else{
	echo('ERROR: no token given');
	exit();
}

if(!(isset($_POST['mid'])&&isset($_POST['title'])&&isset($_POST['category'])&&isset($_POST['startdate'])&&isset($_POST['enddate']))){
	echo('ERROR: missing params');
	exit();
}
//Check that user is the owner of the film
$emailq=curl_init();
curl_setopt($emailq,CURLOPT_URL,'http://orion:1026/v2/entities/'.$_POST['mid']);
curl_setopt($emailq,CURLOPT_HTTPHEADER, array('Accept: application/json'));
curl_setopt($emailq,CURLOPT_RETURNTRANSFER,true);
$emailqres=json_decode(curl_exec($emailq),true);
curl_close($emailq);
if(!isset($emailqres['owneremail']['value'])||$emailqres['owneremail']['value']!=$res['email']){
	echo('ERROR: owner different from user attempting the update');
	exit();
}
//Update film
$data=json_encode(array('title'=>array('value'=>$_POST['title']),
						'category'=>array('value'=>$_POST['category']),
						'startdate'=>array('value'=>$_POST['startdate']),
						'enddate'=>array('value'=>$_POST['enddate'])));
$q=curl_init();
curl_setopt($q,CURLOPT_CUSTOMREQUEST,'PATCH');
curl_setopt($q,CURLOPT_POSTFIELDS,$data);
curl_setopt($q,CURLOPT_URL,'http://orion:1026/v2/entities/'.$_POST['mid'].'/attrs');
curl_setopt($q, CURLOPT_HTTPHEADER, array('Content-Type: application/json'));
curl_exec($q);
if(curl_getinfo($q,CURLINFO_HTTP_CODE)==204){
	echo('OK');
}else{
	echo('ERROR: Orion error');
}
curl_close($q);	

?>