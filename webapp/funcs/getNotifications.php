<?php
//POST params: token
//returns: json list of {
//						title:...,
//						cinemaname:...,
//						startdate:...,
//						enddate:...,
//						}

if(!isset($_POST['token'])){
	echo('ERROR: no token given');
	exit();
}
//Get notifications for user
$fq=curl_init();
curl_setopt($fq,CURLOPT_URL,'http://data-server:80/get_all_notif/');
curl_setopt($fq,CURLOPT_HTTPHEADER,array('Content-Type: application/x-www-form-urlencoded'));
curl_setopt($fq,CURLOPT_POST,true);
curl_setopt($fq,CURLOPT_POSTFIELDS,'token='.$_POST['token']);
curl_setopt($fq,CURLOPT_RETURNTRANSFER,true);
$res=json_decode(curl_exec($fq),true);
curl_close($fq);
//Get cinema names
$cq=curl_init();
curl_setopt($cq,CURLOPT_URL,'http://data-server:80/get_all_cin_names/');
curl_setopt($cq,CURLOPT_RETURNTRANSFER,true);
$cnames=json_decode(curl_exec($cq),true);
curl_close($cq);
//Join notifications with cinema names
$cmap=array();
for($i=0; $i<count($cnames); $i++){
	$cmap[$cnames[$i]['email']]=$cnames[$i]['name'];
}
unset($cnames);
for($i=0; $i<count($res); $i++){
	$res[$i]['cinemaname']=$cmap[$res[$i]['owneremail']];
	unset($res[$i]['owneremail']);
}
echo(json_encode($res));