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
	  <title>Welcome!</title>
	  <link rel="stylesheet" type="text/css" href="styles.css">
	 </head>
	 <body onload='bodyLoaded()'>
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
				}?>
			</div>
		</div>
		<div class='menucont onright'>
			<button class='menubtn'> <?php echo($username.' ('.$role.') ') ?><i class="arrowdown"></i></button>
			<div class='dropmenu'>
				<?php echo("<a href='index.php?token=".$_GET['token']."'>Log out</a>"); ?>
			</div>
		</div>
		</div>
		<div class='mainpage'>
		<h1 class='maintitle'>News:</h1>
		<div id='newsdiv' class='maintitle'>
		</div>
		<script>
			function writeNotifications(req){
				var res=JSON.parse(req.responseText);
				if(res.length==0){
					document.getElementById('newsdiv').innerHTML='There are no news currently. You will be notified immediately when one of your favorite movies starts or stops being available on a cinema';
					return;
				}
				var today = new Date();
				var dd = String(today.getDate()).padStart(2, '0');
				var mm = String(today.getMonth() + 1).padStart(2, '0');
				var yyyy = today.getFullYear();
				today=yyyy+'-'+mm+'-'+dd;
				var newsstr='<table>';
				for(var i=0; i<res.length; i++){
					if(res[i].enddate<today){
						newsstr+="<tr><td>'"+res[i].title+"' has stopped playing</td></tr>";
					}else{
						newsstr+="<tr><td>'"+res[i].title+"' is now playing on cinema '"+res[i].cinemaname+"'</td></tr>";
					}
				}
				document.getElementById('newsdiv').innerHTML=newsstr+'</table>';
			}
			function updateNotifications(){
				var req=new XMLHttpRequest();
				req.onreadystatechange=function(){
					if(this.readyState==4 && this.status==200){
						writeNotifications(this);
					}
				}
				req.open("POST",'funcs/getNotifications.php',true);
				req.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
				req.send("token=<?php echo($_GET['token']); ?>");
			}
			function bodyLoaded(){
				updateNotifications();
				setInterval(updateNotifications,5000);
			}
		</script>
	 </body>
	</html>






