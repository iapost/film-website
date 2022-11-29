<?php
//POST params: token, mid
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
		if(!isset($res['roles'][0]['name'])){
			echo('ERROR: invalid token');
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
//Create subscription in orion
$q=curl_init();
$data=array('subject'=>array('entities'=>array(array('id'=>$_POST['mid'],'type'=>'Movie')),
							'condition'=>array('attrs'=>array('startdate','enddate'))),
			'notification'=>array('httpCustom'=>array('url'=>'http://webapp:80/funcs/saveNotification.php','qs'=>array('email'=>$email)),
								  'attrs'=>array('title','owneremail','startdate','enddate'),
								  'attrsFormat'=>'keyValues')
			);
curl_setopt($q,CURLOPT_POST,true);
curl_setopt($q,CURLOPT_POSTFIELDS,json_encode($data));
curl_setopt($q,CURLOPT_URL,'http://orion:1026/v2/subscriptions');
$headers = array('Content-Type: application/json');
curl_setopt($q, CURLOPT_HTTPHEADER, $headers);
curl_setopt($q,CURLOPT_RETURNTRANSFER,true);
curl_setopt($q,CURLOPT_HEADER,true);
$res=curl_exec($q);
if(curl_getinfo($q,CURLINFO_HTTP_CODE)!=201){
	echo('ERROR: Orion error'.$res);
	exit();
}
//Get subscription id of new subscription
$hsize=curl_getinfo($q,CURLINFO_HEADER_SIZE);
$headarr=explode("\r\n",substr($res,0,$hsize));
$subid='';
foreach($headarr as $value){
	if(strtolower(substr($value,0,8))=="location"){
		$subid=substr($value,strlen($value)-24,24);
	}
}
curl_close($q);
//Save subscription id and movie id in data server
$data=array('token'=>$_POST['token'],
			'mid'=>$_POST['mid'],
			'subid'=>$subid);
$fq=curl_init();
curl_setopt($fq,CURLOPT_POST,true);
curl_setopt($fq,CURLOPT_POSTFIELDS,$data);
curl_setopt($fq,CURLOPT_URL,'http://data-server:80/add_fav/');
curl_exec($fq);
curl_close($fq);
?>