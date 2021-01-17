<?php
        $req = $_GET["req"];
        $body = "";
        //print("Req: $req");

        include("./auth.php");
        //print("req: $req");
        if($req == "get"){
                $body = exec("python3 get.py");
        }elseif($req == "update"){
                $args = $_GET["args"];
                //print("python3 update.py $args");
                $body = exec("python3 update.py $args");
        }elseif($req == "fakeGET"){
                $body = <<<'DOC'
                {
                "users":[{"name":"asgar","id":"AAAAAAA"}],
                "games":[{"title":"Regular hunt","tags":"A","description":"A regular old game, actually.","id":"GAMEONE","host":"asgar"}],
                "tags":[{"title":"dog","tag":"dog","hasScored":"AAAAAAA","value":10, "id":"A"}]
                }
                DOC;
        }

        print($body);


?>
