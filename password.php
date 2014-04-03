<head><title>Preposterous Password Producer</title></head>
<?php
// Insert default vaules
$wordcsv = $_POST['wordlistdropdown'];
if (empty($wordcsv)) {
	$wordcsv = "wordlists/_sensi-words.csv";
}

$numofpword = $_POST['numberofpasswordsinput'];
if (empty($numofpword)) {
        $numofpword = "1";
}

$numofword = $_POST['numberofwordsinput'];
if (empty($numofword)) {
        $numofword = "3";
}

$capitalstatus = $_POST['caplistdropdown'];
if (empty($capitalstatus)) {
        $capitalstatus = "capitalwords";
}

$minwordlen = $_POST['wldropdown'];
if (empty($minwordlen)) {
        $minwordlen = "10";
}

// set limits
if ( $numofpword > 1000) { $numofpword = "1000";}
//if ( $numofword < 2) { $numofword = "2";}
//if ( $numofword > 10) { $numofword = "10";}


$words = array_filter(explode("\n",file_get_contents("$wordcsv")));
$wordCount = count($words);

// pick a random word then get suggestions for it
$passwords = array();

$qty = (int)$numofpword;

for($i=0;$i<$qty;$i++) {
  $wordList = array();
  while(count($wordList) < $numofword) {
    $suggestion = $words[rand(0,$wordCount-1)];
    if(isSuitableWord($suggestion)) {
#if ( $suggestion > 7 ){
      $suggestion = strtolower($suggestion);

//check capitalisation list and set word appropriately
        if  ( $capitalstatus == "nocaps" )  {
                $suggestion = strtolower($suggestion);
        }

        // make one of the words randomly uppercase
	// I wrote this code to alternate between upper and lower case
	// it doesn't do that but I prefer what it does do
	if ( $capitalstatus == "capitalwords" )	{
        	$wordupperness = rand(0,500);
                        if ( $wordupperness > 250)         {
                                $suggestion = strtoupper($suggestion);
                                                        }
                        else            {
                                $suggestion = $suggestion;
                                        }
						}
	if  ( $capitalstatus == "capitalletters" )  {

		
        	// make one of the letters randomly uppercase
		$characterIndex = rand(0,strlen($suggestion)-1);
        	$suggestion[$characterIndex] = strtoupper($suggestion[$characterIndex]);
							}
      $wordList[] = $suggestion;
//      $foundSuitableWord = true;
    }
  }

  // add a 4 digit number to the end
  $pin1 = rand(0000,9999);
  $pin = str_pad("$pin1", 4, '0', STR_PAD_LEFT); 

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


echo "<br>";
echo "<br>";
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
echo "<form action='password.php' method='post'>";

echo "Options: (Alpha testing, may not work yet)";
echo "<br>";
echo "Word List:";
echo "<select name='wordlistdropdown'>";
echo "<option value=''></option>";


//$scandir    = 'wordlists';
//$files = scandir($scandir);


//this bit looks in the wordlists directory and gets all the CSVs
$files = array();
foreach (glob("wordlists/*.csv") as $file) {
  $files[] = $file;
}

    foreach($files as $category)
    {
       $category = htmlspecialchars($category);
       echo '<option value="'. $category .'">'. $category .'</option>';
    }
?>
</select>
<br>
Formatting: <select name="caplistdropdown">
<option value="capitalwords">CAPITAL words</option>
<option value="capitalletters">cApitaL LeTters</option>
<option value="nocaps">lower case</option>

</select>
<br>
How many passwords you want? <input type="number" name="numberofpasswordsinput" max="1000" style="width: 40px;"  /> (Max: 1000)
<br>
How many words in you want in each password? 

<?php 
//this selects the number of words to use in each password, defaulting at 3
echo "<select name='numberofwordsinput'>";
echo "<option value='2' >2</option>";
echo "<option value='3' selected>3</option>";
foreach (range(4,10) as $numberofwordsinput) {
 echo "<option value='$numberofwordsinput'>$numberofwordsinput</option>";
}
echo "</select>";
//<input type="number" name="numberofwordsinput" min="2" max="10" style="width: 20px;"  /> (Max: 10)
echo "<br>";


//this bit doesn't work
echo "Minimum Word Length:";

echo "<select name='wldropdown'>";
#$wlrange = range(3,10);
echo "<option value='4' selected>4</option>";
foreach (range(3,10) as $wldropdown) {
   echo "<option value='$wldropdown'>$wldropdown</option>";
}
echo "</select>";

echo "<br>";
echo "<p><input type='submit' value='Do it!'></p>";
echo "</form>";

// This bit is meant to ditch words shorter than a specified length, but it isn't working
function isSuitableWord($word, $minwordlen) {
#  if(strlen($word) <= $numofword) {
#    return false;
#  }

  if(strlen($word) < $minwordlen) {
    return false;
  }


  if(!preg_match('/^[a-z0-9]*$/', $word)) {
    return false;
  }

  return true;
}

?>
