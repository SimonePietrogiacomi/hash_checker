#!/bin/bash

hash_name=("" "MD5" "SHA256" "SHA1" "SHA512")
hash_command=("" "md5sum" "sha256sum" "sha1sum" "sha512sum")

if [ ${#hash_name[@]} != ${#hash_command[@]} ]
then
	echo "Error in hash array. Name length is different from command. Please check"
	exit 1
fi

hash_array_length=${#hash_name[@]}

echo "Welcome! This program will compare the hash of a file with the correct one"
echo "Please insert the path of your file"

read file_path

if [[ -f $file_path ]]
then
	echo "Seems like this is a correct path for a file!"
else
	echo "Man, please enter a valid path! I can't waste my time with you"
	exit 1
fi

echo ""

echo "What kind of hash algorithm do you want to use? Insert one of the number below"
for (( i=1; i<${hash_array_length}; i++ ));
do
	echo "$i. ${hash_name[$i]}"
done

read hash_algorithm

echo ""

if [[ "$hash_algorithm" =~ ^[0-9]+$ ]] && [ "$hash_algorithm" -gt 0 ] && [ "$hash_algorithm" -lt "$hash_array_length" ]
then
	echo "Nice!"
else
	echo "Aoh, insert one of the numbers up here"
	exit 1
fi

echo ""

echo "The last thing to do is to insert the string of the correct hash"

read correct_hash

# TODO: check if correct_hash have whitespaces, newlines or other useless stuff

echo ""

echo "Calculating hash of your file"

local_hash="`${hash_command[$hash_algorithm]} $file_path | awk '{print $1}'`"

echo ""

echo "Done!"

if [ "$local_hash" == "$correct_hash" ]
then
	echo "Match! The hash is correct"
else
	echo "Hash file doesn't match. Check if you put the correct hash string, or try to download again the file"
fi
