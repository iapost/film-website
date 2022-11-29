<?php 
if(isset($_GET['token'])){
	$cq=curl_init();
	curl_setopt($cq,CURLOPT_URL,'http://fiware-idm:3000/user?access_token='.$_GET['token']);
	curl_setopt($cq, CURLOPT_RETURNTRANSFER,true);
	$response=curl_exec($cq);
	curl_close($cq);
	if($response==false){
		exit(header("Location: index.php"));
	}else{
		$res=json_decode($response,true);
		if(!isset($res['roles'][0]['name'])){
			exit(header("Location: index.php"));
		}
		$role=$res['roles'][0]['name'];
		$username=$res['username'];
	}
}else{
	exit(header("Location: index.php"));
}
if($role!='ADMIN'){
	exit(header("Location: index.php?token=".$_GET['token']));
}
?>
<html>
 <head>
  <title>Manage users</title>
  <link rel="stylesheet" type="text/css" href="styles.css">
 </head>
 <body onload='refreshUsers(null)'>
	<div class='menubar'>
		<div class='menucont'>
			<button class='menubtn'>Menu</button>
			<div class='dropmenu'>
				<?php
					echo("<a href='welcome.php?token=".$_GET['token']."'>Welcome page</a>");
					echo("<a href='movies.php?token=".$_GET['token']."'>Browse movies</a>");
					echo('<a href="administration.php?token='.$_GET['token'].'">Manage users</a>');
				?>
			</div>
		</div>
		<div class='menucont onright'>
			<button class='menubtn'> <?php echo($username.' ('.$role.') ') ?><i class="arrowdown"></i></button>
			<div class='dropmenu'>
				<?php echo('<a href="index.php?token='.$_GET['token'].'">Log out</a>'); ?>
			</div>
		</div>
	</div>
	<div class='mainpage'>
		<h1 class='maintitle'>Manage Users</h1>
		
		<div id='newusertable'>
			</table>
		</div><p>
		
		<div>
			Users:
			<table id="usertable"></table>
		</div>
	</div>
	 <script>
	 function enable_new_user(email){
		var btnlist=document.getElementsByClassName('editdelbtn');
		for(var i=0; i<btnlist.length; i++){
			btnlist[i].disabled=true;
		}
		makeRequest('funcs/enableUser.php','token=<?php echo($_GET['token']); ?>&email='+email,refreshUsers);
	 }
	 function delete_new_user(email){
	 	if(!confirm("Are you sure you want to delete this user?")){
			return;
		}
		var btnlist=document.getElementsByClassName('editdelbtn');
		for(var i=0; i<btnlist.length; i++){
			btnlist[i].disabled=true;
		}
		makeRequest('funcs/deleteNewUser.php','token=<?php echo($_GET['token']); ?>&email='+email,refreshUsers);
	 }
	 function writeNewUsers(req){
	 	if(req.responseText.substr(0,6)=='ERROR:'){
	 		alert('Error while retrieving new users: '+req.responseText);
	 		return;
	 	}
	 	var res=JSON.parse(req.responseText);
	 	if(res.length==0){
	 		return;
	 	}
	 	var str='New users who have not been enabled yet:<table>';
	 	str+='<tr><th>E-mail</th><th>Username</th><th>First name</th><th>Last name</th><th>Role</th><th class="noborder"></th></tr>';
	 	for(var i=0; i<res.length; i++){
	 		str+='<tr><td>'+res[i].email+'</td>';
	 		str+='<td>'+res[i].username+'</td>';
	 		str+='<td>'+res[i].name+'</td>';
	 		str+='<td>'+res[i].surname+'</td>';
	 		str+='<td>'+res[i].role+'</td>';
	 		str+='<td class="noborder"><input type="button" class="editdelbtn bigbtn fill" ';
	 		str+='onclick="enable_new_user('+"'"+res[i].email+"'"+')" value="Enable"/></td>';
	 		str+='<td class="noborder"><input type="button" class="editdelbtn bigbtn fill" ';
	 		str+='onclick="delete_new_user('+"'"+res[i].email+"'"+')" value="Delete"></td></tr>';
	 	}
	 	document.getElementById('newusertable').innerHTML=str;
	 }
	 function writeUsers(req){
	 	if(req.responseText.substr(0,6)=='ERROR:'){
	 		alert('Error while retrieving users: '+req.responseText);
	 		return;
	 	}
	 	var res=JSON.parse(req.responseText);
	 	var str='<tr><th>E-mail</th><th>Username</th><th>First name</th><th>Last name</th><th>Role</th><th class="noborder"></th></tr>';
	 	for(var i=0; i<res.length; i++){
	 		str+='<tr><td>'+res[i].email+'</td>';
	 		str+='<td id="usr'+i+'">'+res[i].username+'</td>';
	 		str+='<td id="name'+i+'">'+res[i].name+'</td>';
	 		str+='<td id="surname'+i+'">'+res[i].surname+'</td>';
	 		str+='<td>'+res[i].role+'</td>';
	 		str+='<td class="noborder"><input type="button" class="editdelbtn bigbtn fill" ';
	 		str+='onclick="edit_save_user(this,'+"'"+res[i].id+"'"+')" id="btnedit'+i+'" value="Edit"/></td>';
	 		str+='<td class="noborder"><input type="button" class="editdelbtn bigbtn fill" ';
	 		str+='onclick="delete_user('+"'"+res[i].id+"'"+')" value="Delete"></td></tr>';
	 	}
	 	document.getElementById('usertable').innerHTML=str;
	 }
	 function refreshUsers(req){
	 	if(req!=null && req.responseText!='OK'){
	 		alert(req.responseText);
	 	}
	 	document.getElementById('newusertable').innerHTML='';
	 	document.getElementById('usertable').innerHTML='';
	 	makeRequest('funcs/getNewUsers.php','token=<?php echo($_GET["token"]); ?>',writeNewUsers);
	 	makeRequest('funcs/getUsers.php','token=<?php echo($_GET["token"]); ?>',writeUsers);
	 }
	 function makeRequest(url,postParams,func){
		var req=new XMLHttpRequest();
		req.onreadystatechange=function(){
			if(this.readyState==4 && this.status==200){
				func(this);
			}
		}
		req.open("POST",url,true);
		req.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		req.send(postParams);
	} 
	function edit_save_user (btn,userid) { 
		var num=btn.id.substr(7);
		if(btn.value=='Edit'){
			btn.value='Save';
			var btnlist=document.getElementsByClassName('editdelbtn');
			for(var i=0; i<btnlist.length; i++){
				if(btnlist[i].id!=btn.id){
					btnlist[i].disabled=true;
				}
			}
			
			var obj=document.getElementById('usr'+num);
			var oldvalue=obj.innerHTML;
			obj.innerHTML='<input id="txtusername" type="text" maxlength="100" value="'+oldvalue+'">';

			obj=document.getElementById('name'+num);
			oldvalue=obj.innerHTML;
			obj.innerHTML='<input id="txtname" type="text" maxlength="50" value="'+oldvalue+'">';
			
			obj=document.getElementById('surname'+num);
			oldvalue=obj.innerHTML;
			obj.innerHTML='<input id="txtsurname" type="text" maxlength="50" value="'+oldvalue+'">';
		}else{
			btn.disabled=true;
			var name=document.getElementById('txtname').value;
			if(name.includes("'") || name.includes('"') || name.includes(';')){
				alert('New name cannot contain quotes, double quotes and semicolons');
				return;
			}
			var surname=document.getElementById('txtsurname').value;
			if(surname.includes("'") || surname.includes('"') || surname.includes(';')){
				alert('New surname cannot contain quotes, double quotes and semicolons');
				return;
			}
			var username=document.getElementById('txtusername').value;
			if(username.includes("'") || username.includes('"') || username.includes(';')){
				alert('New username cannot contain quotes, double quotes and semicolons');
				return;
			}
			var data='token=<?php echo($_GET['token']); ?>&userid='+userid+'&username='+username+'&name='+name+'&surname='+surname;
			makeRequest('funcs/updateUser.php',data,refreshUsers);
		}
	}
	function delete_user(userid){ 
		if(!confirm("This will delete all user's data, including any cinema and the associated movies if he is an owner. Are you sure you want to continue?")){
			return;
		}
		var btnlist=document.getElementsByClassName('editdelbtn');
		for(var i=0; i<btnlist.length; i++){
			btnlist[i].disabled=true;
		}
		makeRequest('funcs/deleteUser.php','token=<?php echo($_GET['token']); ?>&userid='+userid,refreshUsers);
	}
	</script>
	
 </body>
</html>













