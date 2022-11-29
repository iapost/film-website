<html>
<head>
<title>Sign Up</title>
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<div class='mainpage loginmain'>
<h1 style='text-align:center'>Sign up</h1>
<p>Enter the required information below:<p>
E-mail: <input id='txtemail' type="text" maxlength="100" name="email"> <p>
Password: <input id="txtpsw" type="password" maxlength="100" name="password"> <p>
Confirm password: <input id="txtconfpsw" type="password" maxlength="100"> <p>
Username: <input id="txtusername" type="text" maxlength="50" name="username"> <p>
First Name: <input id='txtname' type="text" maxlength="50"> <p>
Last Name: <input id='txtsurname' type="text" maxlength="50" name="surname"> <p>
Role: <br>
<input type="radio" checked=True id="user" name="role" value="USER"> 
<label for="user">User</label><br>
<input type="radio" id="cinown" name="role" value="CINEMAOWNER">
<label for="cinown">Cinema Owner</label><br>
<input type="radio" name="role" id="admin" value="ADMIN">
<label for="admin">Administrator</label><p>
<span style="color:red" id='errorStr'></span><p>
<input type="button" class='bigbtn' value="Submit" onclick="submitForm()" id='btnsub'>
<input type="button" class='bigbtn' value="Cancel" onclick="window.location.href='index.php'">
<div>
<script>
function submitFinished(req){
	var res=req.responseText;
	if(res=='OK'){
		window.location.href='index.php';
	}else{
		document.getElementById('errorStr').innerHTML=res.substr(6).trim();
		document.getElementById('btnsub').disabled=false;
	}
}
function submitForm(){//Checks for errors and redirects to signup.php for inserting values to db
	var usrname=document.getElementById('txtusername').value;
	if(usrname.includes("'") || usrname.includes('"') || usrname.includes(';')){
		alert('Username cannot contain quotes, double quotes and semicolons');
		return;
	}
	var psw=document.getElementById('txtpsw').value;
	var psw2=document.getElementById('txtconfpsw');
	if(psw!=psw2.value){
		alert('Passwords must match');
		return;
	}
	if(psw.includes("'") || psw.includes('"') || psw.includes(';')){
		alert('Password cannot contain quotes, double quotes and semicolons');
		return;
	}
	var name=document.getElementById('txtname').value;
	if(name.includes("'") || name.includes('"') || name.includes(';')){
		alert('Name cannot contain quotes, double quotes and semicolons');
		return;
	}
	var surname=document.getElementById('txtsurname').value;
	if(surname.includes("'") || surname.includes('"') || surname.includes(';')){
		alert('Surname cannot contain quotes, double quotes and semicolons');
		return;
	}
	var email=document.getElementById('txtemail').value;
	if(email.includes("'") || email.includes('"') || email.includes(';')){
		alert('E-mail cannot contain quotes, double quotes and semicolons');
		return;
	}
	if(email==""||!email.includes("@")||(!email.endsWith(".com")&&!email.endsWith(".gr"))){
		alert('Invalid e-mail');
		return;
	}
	var radios=document.getElementsByName('role');
	var role='';
	for(var i=0; i<radios.length; i++){
		if(radios[i].checked){
			role=radios[i].value;
			break;
		}
	}
	document.getElementById('btnsub').disabled=true;
	var req=new XMLHttpRequest();
	req.onreadystatechange=function(){
		if(this.readyState==4 && this.status==200){
			submitFinished(this);
		}
	}
	req.open("POST",'funcs/addUser.php',true);
	req.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
	req.send('username='+usrname+'&password='+psw+'&name='+name+'&surname='+surname+'&email='+email+'&role='+role);
}
</script>
</body>
</html>
