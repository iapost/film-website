<?php
//POST params: token,title,category,startdate,enddate
//returns: OK if successful or error message
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
if(!(isset($_POST['title'])&&isset($_POST['category'])&&isset($_POST['startdate'])&&isset($_POST['enddate']))){
	echo('ERROR: missing params');
	exit();
}
//Get new unique id for the movie
$idq=curl_init();
curl_setopt($idq,CURLOPT_URL,'http://data-server:80/get_new_mid/');
curl_setopt($idq,CURLOPT_RETURNTRANSFER,true);
$id=curl_exec($idq);
if(curl_getinfo($idq,CURLINFO_HTTP_CODE)!=200){
	echo('ERROR: could not get id for new movie');
	exit();
}
curl_close($idq);
//Add movie in orion
$data=json_encode(array('id'=>$id,
						'type'=>'Movie',
						'title'=>array('value'=>$_POST['title']),
						'category'=>array('value'=>$_POST['category']),
						'startdate'=>array('value'=>$_POST['startdate']),
						'enddate'=>array('value'=>$_POST['enddate']),
						'owneremail'=>array('value'=>$email)));
$q=curl_init();
curl_setopt($q,CURLOPT_POST,true);
curl_setopt($q,CURLOPT_POSTFIELDS,$data);
curl_setopt($q,CURLOPT_URL,'http://orion:1026/v2/entities/');
$headers = array('Content-Type: application/json');
curl_setopt($q, CURLOPT_HTTPHEADER, $headers);
curl_exec($q);
if(curl_getinfo($q,CURLINFO_HTTP_CODE)==201){
	echo('OK');
}else{
	echo('ERROR: Orion error');
}
curl_close($q);
?>
