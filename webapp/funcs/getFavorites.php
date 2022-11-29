<?php
//POST params: token
//returns: ERROR:... or json list of {
//							id:...,
//							type:"Movie",
//							title:...,
//							category:...,
//							startdate:...,
//							enddate:...,
//							owneremail:....
//							favorite:<subid>/"",
//							cinemaname:...
//						}

if(!isset($_POST['token'])){
	echo('ERROR: no token given');
	exit();
}
//Get favorites from data server
$fq=curl_init();
curl_setopt($fq,CURLOPT_URL,'http://data-server:80/get_favs/');
curl_setopt($fq,CURLOPT_HTTPHEADER,array('Accept: application/json'));
curl_setopt($fq,CURLOPT_POST,true);
curl_setopt($fq,CURLOPT_POSTFIELDS,array('token'=>$_POST['token']));
curl_setopt($fq,CURLOPT_RETURNTRANSFER,true);
$favs=curl_exec($fq);
curl_close($fq);
if(substr($favs,0,5)=='ERROR'){
	echo($favs);
	exit();
}
$favres=json_decode($favs,true);
if(count($favres)==0){
	echo('[]');
	exit();
}
//Create associative array with favorites
$idbody=array('entities'=>array());
$favmap=array();
for($i=0; $i<count($favres); $i++){
	$favmap[$favres[$i]['mid']]=$favres[$i]['subid'];
	$idbody['entities'][]=array('id'=>$favres[$i]['mid']);
}
//Get info about favorite films from orion
$q=curl_init();
curl_setopt($q,CURLOPT_URL,'http://orion:1026/v2/op/query?options=keyValues&limit=1000');
curl_setopt($q,CURLOPT_HTTPHEADER,array('Accept: application/json','Content-Type: application/json'));
curl_setopt($q,CURLOPT_POST,true);
curl_setopt($q,CURLOPT_POSTFIELDS,json_encode($idbody));
curl_setopt($q,CURLOPT_RETURNTRANSFER,true);
$movies=json_decode(curl_exec($q),true);
//Join films with favorites
for($i=0; $i<count($movies); $i++){
	$movies[$i]['favorite']=$favmap[$movies[$i]['id']];
}
unset($favmap);
//Get cinema names
$nq=curl_init();
curl_setopt($nq,CURLOPT_URL,'http://data-server:80/get_all_cin_names/');
curl_setopt($nq,CURLOPT_RETURNTRANSFER,true);
$cnames=json_decode(curl_exec($nq),true);
curl_close($nq);
//Create associative array with cinema names
$cmap=array();
for($i=0; $i<count($cnames); $i++){
	$cmap[$cnames[$i]['email']]=$cnames[$i]['name'];
}
unset($cnames);
//Join films with cinema names
for($i=0; $i<count($movies); $i++){
	$movies[$i]['cinemaname']=$cmap[$movies[$i]['owneremail']];
}
echo(json_encode($movies));
?>