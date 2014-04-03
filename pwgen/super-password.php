<?php
$words = array_filter(explode("\n",file_get_contents("words.csv")));
$wordCount = count($words);

// generate a random 5 letter word then get suggestions for it
$qty = 1;
$passwords = array();

if(!empty($_GET['qty']) && is_numeric($_GET['qty'])) {
  $qty = (int)$_GET['qty'];
}
for($i=0;$i<$qty;$i++) {
  $wordList = array();
  while(count($wordList) < 3) {
    $suggestion = $words[rand(0,$wordCount-1)];
    if(isSuitableWord($suggestion)) {
      $suggestion = strtolower($suggestion);

      if(!empty($_GET['caps'])) {
        // make one of the characters randomly uppercase
        $characterIndex = rand(0,strlen($suggestion)-1);
        $suggestion[$characterIndex] = strtoupper($suggestion[$characterIndex]);
      }

      $wordList[] = $suggestion;
      $foundSuitableWord = true;
    }
  }
  // add a 4 digit number to the end
  $pin = rand(1000,9999);
  $wordList[] = $pin;
  shuffle($wordList);
  $separators = '@#$%:-_^';
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
<a href="http://wiki.noc.domain.net/password.php">Simpler passwords</a>
<br>
<a href="http://wiki.noc.domain.net/super-password.php">A single password</a>
<br>
<a href="http://wiki.noc.domain.net/super-password.php?qty=50">A whole bunch of passwords</a>
<br>
<a href="http://wiki.noc.domain.net/super-password.php?qty=10&caps=true">Passwords with random capitals</a>
