<?php 
if(isset($_GET['token'])){
	$cq=curl_init();
	curl_setopt($cq,CURLOPT_URL,'http://fiware-idm:3000/oauth2/revoke');
	curl_setopt($cq,CURLOPT_POST,true);
	curl_setopt($cq,CURLOPT_POSTFIELDS,'token='.$_GET['token'].'&token_type_hint=access_token');
	$headers = array(
		'Accept: application/json',
	    'Authorization: Basic YmNmNTIxNjItNzEyMC00N2QyLTg5MzQtYzg4NjU1MGU4NjUyOjYzNzA3ZTkyLWM4NmQtNGUwMC04ZDhlLTMxODdkNWZhMTZiZA==',
	    'Content-Type: application/x-www-form-urlencoded');
	curl_setopt($cq, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($cq, CURLOPT_RETURNTRANSFER,true);
	curl_exec($cq);
	curl_close($cq);
}
?>
<html>
 <head>
  <title>Log In</title>
  <link rel="stylesheet" type="text/css" href="styles.css">
 </head>
 <body>
 <div class='mainpage loginmain'>
	<h1 style='text-align:center'>Log in</h1>
	E-mail: <input type="text" id="txtemail" name="email"> <p> 
	Password: <input type="password" id="txtpsw" name="password"> <p> 
	<input class='bigbtn' id="btnlogin" type="button" onclick='check_login()' value="Log in"/>
	<span style="color:red" id="errorspace"></span><p>
 <div>
 <h2 style='text-align:center'>Don't have an account yet?</h2> <p>
 <input class='bigbtn centbtn' type="button" value="Sign Up" onclick='window.location.href="signup.php"'>
</div>
 </div>
 <script>
 	function check_login(){
 		var email=document.getElementById('txtemail').value;
 		var psw=document.getElementById('txtpsw').value;
 		if(email.includes("'") || email.includes('"')){
			alert('E-mail cannot contain quotes and double quotes');
			return;
		}
		if(psw.includes("'") || psw.includes('"')){
			alert('Password cannot contain quotes and double quotes');
			return;
		}
		document.getElementById('btnlogin').disabled=true;
 		var req=new XMLHttpRequest();
 		req.onreadystatechange=function(){
 			if(this.readyState==4&&this.status==200){
 				if(this.responseText=="ERROR"){
 					if(document.getElementById('errorspace').innerHTML==""){
 						document.getElementById('errorspace').innerHTML='Wrong e-mail or password. Your account may have not been approved by an admin yet';
 					}
 					document.getElementById('btnlogin').disabled=false;
 				}else{
 					window.location.replace("welcome.php?token="+this.responseText);
 				}
 			}
 		}
 		req.open("POST","funcs/login.php",true);
 		req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
 		req.send("email="+email+"&password="+psw);
 	}
 </script>
 </body>
</html>






