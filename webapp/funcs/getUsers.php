<?php
//POST params: token
//returns json list of {id,email,username,name,surname,role} or error message
$pq=curl_init();
//Get admin token for keyrock
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
//Get all users in keyrock
$q=curl_init();
curl_setopt($q,CURLOPT_URL,'http://fiware-idm:3000/v1/applications/bcf52162-7120-47d2-8934-c886550e8652/users');
curl_setopt($q,CURLOPT_HTTPHEADER,array('X-Auth-token: '.$authtoken));
curl_setopt($q,CURLOPT_RETURNTRANSFER,true);
$users=json_decode(curl_exec($q),true);
curl_close($q);
//Get info of all users from database
$eq=curl_init();
curl_setopt($eq,CURLOPT_URL,'http://data-server:80/get_all_users/');
curl_setopt($eq,CURLOPT_POST,true);
curl_setopt($eq,CURLOPT_POSTFIELDS,'token='.$_POST['token']);
curl_setopt($eq,CURLOPT_RETURNTRANSFER,true);
curl_setopt($eq,CURLOPT_HTTPHEADER,array('Content-Type: application/x-www-form-urlencoded'));
$res=curl_exec($eq);
curl_close($eq);
if(substr($res,0,6)=='ERROR:'){
	echo($res);
	exit();
}
$info=json_decode($res,true);
//Create final array with users
$uq=curl_init();
curl_setopt($uq,CURLOPT_HTTPHEADER,array('X-Auth-token: '.$authtoken));
curl_setopt($uq,CURLOPT_RETURNTRANSFER,true);
$finalusers=array();
for($i=0; $i<count($users["role_user_assignments"]); $i++){
	$tmp=$users["role_user_assignments"][$i]["role_id"];
	if($tmp=="8cb2781c-17a5-4a12-8ec1-b6a065ed85fd"){
		$role='ADMIN';
	}else if($tmp=="c954a7f5-a4a4-4b3c-b048-227ed0f6aace"){
		$role='CINEMAOWNER';
	}else if($tmp=="12ab3051-f54a-49ba-afb1-461564987bce"){
		$role='USER';
	}else{
		continue;
	}
	$id=$users["role_user_assignments"][$i]["user_id"];
	curl_setopt($uq,CURLOPT_URL,'http://fiware-idm:3000/v1/users/'.$id);
	$tempres=json_decode(curl_exec($uq),true);
	$username=$tempres["user"]["username"];
	$email=$tempres["user"]["email"];
	$name='';
	$surname='';
	for($j=0; $j<count($info); $j++){
		if($info[$j]["email"]==$email){
			$name=$info[$j]["name"];
			$surname=$info[$j]["surname"];
			break;
		}
	}
	$finalusers[]=array("id"=>$id,"email"=>$email,"username"=>$username,"name"=>$name,"surname"=>$surname,"role"=>$role);
}
curl_close($uq);
echo(json_encode($finalusers));
?>