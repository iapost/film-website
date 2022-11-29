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
?>
<html>
 <head>
  <title>All movies</title>
  <link rel="stylesheet" type="text/css" href="styles.css">
 </head>
 <body onload='getAllMovies(null)'>
	<div class='menubar'>
	<div class='menucont'>
		<button class='menubtn'>Menu</button>
		<div class='dropmenu'>
			<?php
			echo("<a href='welcome.php?token=".$_GET['token']."'>Welcome page</a>");
			echo("<a href='movies.php?token=".$_GET['token']."'>Browse movies</a>");
			if($role=='CINEMAOWNER'){
				echo('<a href="owner.php?token='.$_GET['token'].'">Add/Edit movies</a>');
			}else if($role=='ADMIN'){
				echo('<a href="administration.php?token='.$_GET['token'].'">Manage users</a>');
			}
			?>
		</div>
	</div>
	<div class='menucont onright'>
		<button class='menubtn'> <?php echo($username.' ('.$role.') ') ?><i class="arrowdown"></i></button>
		<div class='dropmenu'>
			<?php 
			echo('<a href="index.php?token='.$_GET['token'].'">Log out</a>');
			?>
		</div>
	</div>
	</div>
	<div class='mainpage'>
	<h1 class='maintitle'>Browse movies</h1>
	Search by: 
	<select id='searchby' onchange='dateOrText(this)'>
		<option value='TITLE'>Title</option>
		<option value='DATE'>Release Date</option>
		<option value='CINEMA'>Cinema</option>
		<option value='CATEGORY'>Category</option>
	</select>
	<input id="txtvalue" type="text">
	<input type="button" class='bigbtn' value="Search" id='btnsearch' onclick='searchMovie()'>
	<input type="button" class='bigbtn' value="Browse All" id='btnbrowseall' onclick='getAllMovies()'>
	<input type="button" class='bigbtn' value="Browse Favorites" id='btnfav' onclick='getFavorites()'><p>
	<h2 id='resultTitle'></h2>
	<div id='resdiv'>
	</div>
<script>
function finishedFavorite(req){
	var btns=document.getElementsByClassName('bigbtn');
	for(var i=0; i<btns.length; i++){
		btns[i].disabled=false;
	}
	if(req.responseText!='OK'){
		alert(req.responseText);
	}
}
function addRemoveFavorite(btn,mid,token){
	var btns=document.getElementsByClassName('bigbtn');
	for(var i=0; i<btns.length; i++){
		btns[i].disabled=true;
	}
	if(btn.value=='Remove from favorites'){
		btn.value='Add to favorites';
		makeRequest('funcs/deleteFavorite.php','mid='+mid+'&token='+token,finishedFavorite);
	}else{
		btn.value='Remove from favorites';
		makeRequest('funcs/addFavorite.php','mid='+mid+'&token='+token,finishedFavorite);
	}
	
}
function updateTable(req){
	document.getElementById('btnsearch').disabled=false;
	document.getElementById('btnbrowseall').disabled=false;
	document.getElementById('btnfav').disabled=false;
	var res=JSON.parse(req.responseText);
	if(res.length==0){
		document.getElementById('resdiv').innerHTML='<h3>No results</h3>';
		return;
	}
	var tableText='<table><tr><th>Title</th><th>Category</th><th>Release Date (dd/mm/yyyy)</th><th>End date (dd/mm/yyyy)</th><th>Cinema</th><th>Cinema Owner</th></tr>';
	for(var i=0; i<res.length; i++){
		tableText+='<tr id="'+res[i].id+'"><td>'+res[i].title+'</td><td>'+res[i].category+'</td>';
		tableText+='<td>'+res[i].startdate.substr(8,2)+'/'+res[i].startdate.substr(5,2)+'/'+res[i].startdate.substr(0,4)+'</td>';
		tableText+='<td>'+res[i].enddate.substr(8,2)+'/'+res[i].enddate.substr(5,2)+'/'+res[i].enddate.substr(0,4)+'</td>';
		tableText+='<td>'+res[i].cinemaname+'</td><td>'+res[i].owneremail+'</td>';
		if(res[i].favorite==''){
			tableText+='<td class="noborder">';
			tableText+='<input type="button" class="fill bigbtn" onclick="'+"addRemoveFavorite(this,'"+res[i].id+"','<?php echo($_GET['token']); ?>')"+'" value="Add to favorites"></td>';	
		}else{
			tableText+='<td class="noborder">';
			tableText+='<input type="button" class="fill bigbtn" onclick="'+"addRemoveFavorite(this,'"+res[i].id+"','<?php echo($_GET['token']); ?>')"+'" value="Remove from favorites"></td>';	
		}
		tableText+='</tr>';
	}
	tableText+='</table>';
	document.getElementById('resdiv').innerHTML=tableText;
}
function writeAllMovies(req){
	document.getElementById('resultTitle').innerHTML='All movies:';
	updateTable(req);
}
function writeFavorites(req){
	document.getElementById('resultTitle').innerHTML='Favorites:';
	updateTable(req);
}
function writeSearchRes(req){
	document.getElementById('resultTitle').innerHTML='Search result:';
	updateTable(req);
}
function getFavorites(){
	request_prep();
	makeRequest('funcs/getFavorites.php','token=<?php echo($_GET["token"]); ?>',writeFavorites);
}
function searchMovie(){
	var value=document.getElementById('txtvalue').value;
	if(value.includes("'") || value.includes('"')){
		alert('Search key cannot contain quotes and double quotes');
		return;
	}
	request_prep();
	var searchby=document.getElementById('searchby').value;
	makeRequest('funcs/searchMovies.php','value='+value+'&searchby='+searchby+'&token=<?php echo($_GET['token']); ?>',writeSearchRes);
}
function getAllMovies(){
	request_prep();
	makeRequest('funcs/getMovies.php','token=<?php echo($_GET['token']); ?>',writeAllMovies);
}
function request_prep(){
	document.getElementById('btnsearch').disabled=true;
	document.getElementById('btnbrowseall').disabled=true;
	document.getElementById('btnfav').disabled=true;
	document.getElementById('resdiv').innerHTML='';
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
function dateOrText(sel){//Changes type of input for search between date and text
	var txt=document.getElementById('txtvalue');
	if(sel.value=='DATE'){
		txt.type='date';
	}else{
		if(txt.type=='date'){
			txt.value='';
		}
		txt.type='text';
	}
}
</script>
 </body>
</html>















