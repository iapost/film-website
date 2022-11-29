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
//Get all movies from orion
$q=curl_init();
curl_setopt($q,CURLOPT_URL,'http://orion:1026/v2/entities?limit=1000&options=keyValues');
curl_setopt($q,CURLOPT_HTTPHEADER,array('Accept: application/json'));
curl_setopt($q,CURLOPT_RETURNTRANSFER,true);
$res=json_decode(curl_exec($q),true);
curl_close($q);
//Get favorites of user
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
//Create associative array with favorites
$favmap=array();
foreach($favres as $value){
	$favmap[$value['mid']]=$value['subid'];
}
unset($value);
//Join films and favorites
for($i=0; $i<count($res); $i++){
	if(isset($favmap[$res[$i]['id']])){
		$res[$i]['favorite']=$favmap[$res[$i]['id']];
	}else{
		$res[$i]['favorite']='';
	}
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
//Join films and cinema names
for($i=0; $i<count($res); $i++){
	$res[$i]['cinemaname']=$cmap[$res[$i]['owneremail']];
}
echo(json_encode($res));
?>