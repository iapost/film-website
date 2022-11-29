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
if($role!='CINEMAOWNER'){
	exit(header("Location: index.php?token=".$_GET['token']));
}
//Get cinema name
$q=curl_init();
curl_setopt($q,CURLOPT_POST,true);
curl_setopt($q,CURLOPT_POSTFIELDS,'token='.$_GET['token']);
curl_setopt($q,CURLOPT_URL,'http://data-server:80/get_my_cin_name/');
curl_setopt($q, CURLOPT_RETURNTRANSFER,true);
$cinemaname=curl_exec($q);
curl_close($q);
?>
<html>
 <head>
  <title>Add/Edit movie</title>
  <link rel="stylesheet" type="text/css" href="styles.css">
 </head>
 <body onload='updateFilms(null)'>
	<div class='menubar'>
	<div class='menucont'>
		<button class='menubtn'>Menu</button>
		<div class='dropmenu'>
			<?php
				echo("<a href='welcome.php?token=".$_GET['token']."'>Welcome page</a>");
				echo("<a href='movies.php?token=".$_GET['token']."'>Browse movies</a>");
				echo('<a href="owner.php?token='.$_GET['token'].'">Add/Edit movies</a>');
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
	<h1 class='maintitle'>Add/Edit movie</h1>
	<div><b>My cinema's name:</b>
	<input id="txtName" maxlength="50" value="<?php echo($cinemaname); ?>" type="text">
	<input type="button" class='bigbtn' id="savebtn" value="Save changes" onclick="saveCinemaName()"><span style="color:green" id="okspace"></span></div><p>
	<div id="tablecont">
		<table id="movietable">
		</table>
	</div>
 
<script>
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
function writeUpdatedFilms(req){
	var htmlStr='<tr><th>Title</th><th>Category</th><th>Release Date (dd/mm/yyyy)</th><th>End Date (dd/mm/yyyy)</th><th class="noborder" colspan=2>';
	htmlStr+='<input class="btneditdelete bigbtn fill" id="btnadd" onclick="add_movie(this)" type="button" value="Add new movie"></th></tr>';
	var res=JSON.parse(req.responseText);
	for(var i=0; i<res.length; i++){
		htmlStr+='<tr><td id="title'+i+'">'+res[i].title+'</td>';
		htmlStr+='<td id="cat'+i+'">'+res[i].category+'</td>';
		htmlStr+='<td id="startdate'+i+'">'+res[i].startdate.substr(8,2)+'/'+res[i].startdate.substr(5,2)+'/'+res[i].startdate.substr(0,4)+'</td>';
		htmlStr+='<td id="enddate'+i+'">'+res[i].enddate.substr(8,2)+'/'+res[i].enddate.substr(5,2)+'/'+res[i].enddate.substr(0,4)+'</td>';
		htmlStr+='<td class="noborder"><input type="button" class="btneditdelete bigbtn fill" id="btned'+i+'" onclick="edit_movie(this,'+"'"+res[i].id+"'"+')" value="Edit"></td>';
		htmlStr+='<td class="noborder"><input type="button" class="btneditdelete bigbtn fill" onclick="delete_movie('+"'"+res[i].id+"'"+')" value="Delete"></td></tr>';
	}
	document.getElementById('movietable').innerHTML=htmlStr;
}
function cinemaSavedInfo(req){
	if(req.responseText=='OK'){
		document.getElementById('okspace').innerHTML=' Saved';
	}else{
		document.getElementById('okspace').innerHTML=' Error during saving';
	}
	document.getElementById('savebtn').disabled=false;
}
function updateFilms(req){
	makeRequest('funcs/getMyMovies.php','token=<?php echo($_GET["token"]); ?>',writeUpdatedFilms);
}
function add_movie(btn){//Inserts new row in table for input
	var btnlist=document.getElementsByClassName('btneditdelete');
	for(var i=0; i<btnlist.length; i++){
		btnlist[i].disabled=true;
	}
	var table=document.getElementById('movietable');
	var newrow=table.insertRow(1);
	newrow.innerHTML='<td><input id="txtnewtitle" type="text" maxlength="100" name="title"></td>';
	newrow.innerHTML+='<td><input id="txtnewcat" type="text" maxlength="200" name="category"></td>';
	newrow.innerHTML+='<td><input type="date" id="startdate"></td>';
	newrow.innerHTML+='<td><input type="date" id="enddate"></td>';
	newrow.innerHTML+='<td class="noborder"><input type="button" class="bigbtn fill" id="btnsavenew" onclick="add_movie_submit()" value="Add"></td>';
	newrow.innerHTML+='<td class="noborder"><input type="button" class="bigbtn fill" id="btncancelnew" onclick="updateFilms(null)" value="Cancel"></td>';
}
function add_movie_submit(){
	document.getElementById('btnsavenew').disabled=true;
	document.getElementById('btncancelnew').disabled=true;
	var title=document.getElementById('txtnewtitle').value;
	if(title.includes("'") || title.includes('"') || title.includes(';')){
		alert('Title cannot contain quotes, double quotes and semicolons');
		return;
	}
	var cat=document.getElementById('txtnewcat').value;
	if(cat.includes("'") || cat.includes('"') || cat.includes(';')){
		alert('Category cannot contain quotes, double quotes and semicolons');
		return;
	}
	var startdate=document.getElementById('startdate').value;
	var enddate=document.getElementById('enddate').value;
	makeRequest('funcs/addMovie.php','token=<?php echo($_GET['token']); ?>&title='+title+'&category='+cat+'&startdate='+startdate+'&enddate='+enddate,updateFilms);
}
function edit_movie(btn,mid){
	if(btn.value=="Edit"){
		btn.value="Save";
		var num=btn.id.substr(5);

		var btnlist=document.getElementsByClassName('btneditdelete');
		for(var i=0; i<btnlist.length; i++){
			if(btnlist[i].id!=btn.id){
				btnlist[i].disabled=true;
			}
		}

		obj=document.getElementById('title'+num);
		oldval=obj.innerHTML;
		obj.innerHTML='<input id="txttitle" type="text" maxlength="100" value="'+oldval+'">';

		obj=document.getElementById('cat'+num);
		oldval=obj.innerHTML;
		obj.innerHTML='<input id="txtcat" type="text" maxlength="200" value="'+oldval+'">';

		obj=document.getElementById('startdate'+num);
		oldval=obj.innerHTML;
		oldval=oldval.substr(6,4)+'-'+oldval.substr(3,2)+'-'+oldval.substr(0,2);
		obj.innerHTML='<input type="date" id="startdate" value="'+oldval+'">';

		obj=document.getElementById('enddate'+num);
		oldval=obj.innerHTML;
		oldval=oldval.substr(6,4)+'-'+oldval.substr(3,2)+'-'+oldval.substr(0,2);
		obj.innerHTML='<input type="date" id="enddate" value="'+oldval+'">';
	}else{
		btn.disabled=true;
		var title=document.getElementById('txttitle').value;
		if(title.includes("'") || title.includes('"') || title.includes(';')){
			alert('Title cannot contain quotes, double quotes and semicolons');
			return;
		}
		var cat=document.getElementById('txtcat').value;
		if(cat.includes("'") || cat.includes('"') || cat.includes(';')){
			alert('Category cannot contain quotes, double quotes and semicolons');
			return;
		}
		var startdate=document.getElementById('startdate').value;
		var enddate=document.getElementById('enddate').value;
		makeRequest('funcs/editMovie.php','token=<?php echo($_GET['token']); ?>&mid='+mid+'&title='+title+'&category='+cat+'&startdate='+startdate+'&enddate='+enddate,updateFilms);		
	}
}
function delete_movie(mid){
	if(confirm("Are you sure you want to delete movie?")){
		var btnlist=document.getElementsByClassName('btneditdelete');
		for(var i=0; i<btnlist.length; i++){
			btnlist[i].disabled=true;
		}
		makeRequest('funcs/deleteMovie.php','token=<?php echo($_GET['token']); ?>&mid='+mid,updateFilms);
	}
}
function saveCinemaName(){
	var txt=document.getElementById('txtName');
	if(txt.value.includes("'") || txt.value.includes('"') || txt.value.includes(';')){
		alert('Cinema name cannot contain quotes, double quotes and semicolons');
		return;
	}
	document.getElementById('savebtn').disabled=true;
	makeRequest('funcs/saveCinemaName.php','token=<?php echo($_GET['token']); ?>&name='+txt.value,cinemaSavedInfo);
}
</script>
</body>
</html>
















 