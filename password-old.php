
<?php
if(!empty($_GET['wordcsv']) ) {
  $wordcsv = $_GET['wordcsv'];
}
#$words = array_filter(explode("\n",file_get_contents($wordcsv".csv")));
$words = array_filter(explode("\n",file_get_contents("sensi-words.csv")));
$wordCount = count($words);

#echo $wordcsv

// generate a random 5 letter word then get suggestions for it
$qty = 1;
$passwords = array();
$wordupper = "maybe";

if(!empty($_GET['qty']) && is_numeric($_GET['qty'])) {
  $qty = (int)$_GET['qty'];
}
for($i=0;$i<$qty;$i++) {
  $wordList = array();
  while(count($wordList) < 3) {
    $suggestion = $words[rand(0,$wordCount-1)];
    if(isSuitableWord($suggestion)) {
      $suggestion = strtolower($suggestion);

      if(empty($_GET['caps'])) {
        // make one of the words randomly uppercase
	// I wrote this code to alternate between upper and lower case
	// it doesn't do that but I prefer what it does do
        $wordupperness = rand(0,500);
                if ( $wordupper = "maybe" )     {
                        if ( $wordupperness > 250)         {
                                $suggestion = strtoupper($suggestion);
                                $wordupper = "no";

                                                        }
                        else            {

                                $suggestion = $suggestion;
                                $wordupper = "yes";
                                        }
                                                }
                else            {
                        if ( $wordupper = "yes" )       {
                                $suggestion = strtoupper($suggestion);
                                $wordupper = "no";
                                                        }
                        else
                        {
                                $suggestion = $suggestion;
                                $wordupper = "yes";
                        }

                                }
                                        }



//        $characterIndex = rand(0,strlen($suggestion)-1);
//        $suggestion[$characterIndex] = strtoupper($suggestion[$characterIndex]);
//      }

      $wordList[] = $suggestion;
      $foundSuitableWord = true;
    }
  }
  // add a 4 digit number to the end
  $pin1 = rand(0000,9999);
  $pin = str_pad("$pin1", 4, '0', STR_PAD_LEFT); 

// $pin = rand(1000,9999);
  $wordList[] = $pin;
  shuffle($wordList);
  $separators = '@#$%:-_^!&*';
  $pass = implode($separators[ rand(0,strlen($separators)-1) ],$wordList);
  $passwords[] = $pass;
}
if(empty($_GET['raw'])) {
  echo '<pre>';
  echo implode(PHP_EOL, $passwords);
  echo '</pre>';
} else {
  echo implode(PHP_EOL, $passwords);
}


function isSuitableWord($word) {
  if(strlen($word) <= 3) {
    return false;
  }

  if(!preg_match('/^[a-z0-9]*$/', $word)) {
    return false;
  }

  return true;
}

?>
<a href="http://wiki.noc.tibus.net/super-password.php">Complicated passwords</a>
<br>
<a href="http://wiki.noc.tibus.net/password.php">A single password</a>
<br>
<a href="http://wiki.noc.tibus.net/password.php?qty=50">A whole bunch of passwords</a>
<br>
<a href="http://wiki.noc.tibus.net/password.php?qty=10&caps=true">Passwords with no capitals</a>
<br>
<form action="passform.php" method="post">

Word List (Alpha testing, may not do anything)
<br>
<select name="wordlistdropdown">
<option value="sensi-words.csv">Sensible</option>
<option value="words.csv">Complex words</option>
<option value="allwords.csv">Long list</option>
</select>
<p><input type="submit" value="Do it!"></p>
</form>

