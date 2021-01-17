<?php
        $req = $_GET["req"];
        $body = "";
        //print("Req: $req");

        if($req == "get"){
                $body = exec("python3 get.py");
        }elseif($req == "update"){
                $args = $_GET["args"];
                $body = exec("python3 update.py $args");
        }

        print($body);


?>
