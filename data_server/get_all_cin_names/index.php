<?php
//returns: json list of {
// 						"email":"...",
//						"name":"..."
//						}

require '../vendor/autoload.php';

$m=new MongoDB\Client("mongodb://mongo-data:27017");
$coll=$m->film_project->cinemas;
$res=$coll->find(array(),array('projection'=>array('_id'=>0)));
echo(json_encode($res->toArray(),true));


