#Created by Jean-Erick Voigt 
#28 Nov 2018

#Create a file if !exist
#new-item -path H:\Desktop\contents.txt -itemtype file

set-location -path Y:
cd Y:\
$arr = (gci).FullName

%($item in $arr) {
	echo "ITEM: $item" #feedback to know the program is running
	$backOne = (gci -recurse $item | ? { $_.name -match "For Bored Ones"}).FullName
	#if bored one directory not present backone string will be less than one
	
	if ($backOne.length -lt 1) { 
		continue
	}
	else {
		$glyph = split-path $backOne
		cd glyph
		$backOne = ""
		(gci | select FullName | % {get-filehash -path $_.FullName -algorithm MD5; get-filehash -path $_.FullName -algorithm SHA256; get-filehash -path $_.FullName -algorithm SHA512} | format-list) >> H:\Desktop\contents.txt
	}
}
