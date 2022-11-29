<?php
//POST params: token,searchby,value
// 			searchby is enum{'TITLE','DATE','CINEMA','CATEGORY'}
//returns: ERROR:... or json list of {
//							id:...,
//							type:"Movie",
//							title:...,
//							category:...,
//							startdate:...,
//							enddate:...,
//							owneremail:....,
//							favorite:<subid>/"",
//							cinemaname:...
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
		if(!isset($res['roles'][0]['name'])){
			echo('ERROR: invalid token or role');
			exit();
		}
		$email=$res['email'];
	}
}else{
	echo('ERROR: no token given');
	exit();
}
if(!isset($_POST['searchby'])||!isset($_POST['value'])){
	echo('ERROR: missing params');
	exit();
}
//Get search result from orion
$q=curl_init();
curl_setopt($q,CURLOPT_HTTPHEADER,array('Accept: application/json'));
curl_setopt($q,CURLOPT_RETURNTRANSFER,true);
if($_POST['searchby']=='TITLE'){
	curl_setopt($q,CURLOPT_URL,"http://orion:1026/v2/entities/?q=title=='".$_POST['value']."'&limit=1000&options=keyValues");
	$res=json_decode(curl_exec($q),true);
}else if($_POST['searchby']=='CATEGORY'){
	curl_setopt($q,CURLOPT_URL,"http://orion:1026/v2/entities/?q=category=='".$_POST['value']."'&limit=1000&options=keyValues");
	$res=json_decode(curl_exec($q),true);
}else if($_POST['searchby']=='DATE'){
	curl_setopt($q,CURLOPT_URL,"http://orion:1026/v2/entities/?q=startdate=='".$_POST['value']."'&limit=1000&options=keyValues");
	$resa=json_decode(curl_exec($q),true);
	curl_setopt($q,CURLOPT_URL,"http://orion:1026/v2/entities/?q=enddate=='".$_POST['value']."'&limit=1000&options=keyValues");
	$resb=json_decode(curl_exec($q),true);
	for($i=0; $i<count($resa); $i++){
		if($resa[$i]['startdate']==$resa[$i]['enddate']){
			unset($resa[$i]);
		}
	}
	$res=array_merge($resa,$resb);
}else if($_POST['searchby']=='CINEMA'){
	curl_setopt($q,CURLOPT_URL,"http://orion:1026/v2/entities/?q=owneremail=='".$_POST['value']."'&limit=1000&options=keyValues");
	$resa=json_decode(curl_exec($q),true);
	curl_setopt($q,CURLOPT_URL,'http://data-server:80/get_owner_email/?name='.$_POST['value']);
	$owneremail=curl_exec($q);
	if(curl_getinfo($q,CURLINFO_HTTP_CODE)==200 && $_POST['value']!=$owneremail){
		curl_setopt($q,CURLOPT_URL,"http://orion:1026/v2/entities/?q=owneremail=='".$owneremail."'&limit=1000&options=keyValues");
		$resb=json_decode(curl_exec($q),true);
		$res=array_merge($resa,$resb);
	}else{
		$res=$resa;
	}
}
curl_close($q);
//If no movies found exit
if(count($res)==0){
	echo('[]');
	exit();
}
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
//Create associative array of favorites
$favmap=array();
foreach($favres as $value){
	$favmap[$value['mid']]=$value['subid'];
}
unset($value);
//Join films with favorites
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
//Create associative array of cinema names
$cmap=array();
for($i=0; $i<count($cnames); $i++){
	$cmap[$cnames[$i]['email']]=$cnames[$i]['name'];
}
unset($cnames);
//Join films with cinema names
for($i=0; $i<count($res); $i++){
	$res[$i]['cinemaname']=$cmap[$res[$i]['owneremail']];
}
echo(json_encode($res));
?>

