cls
echo off
echo "hash checker"
echo ""
echo "the correct md5 hash for this file is given "
echo "by the big number shown below"
type  *.md5

echo ""
echo "the md5 for this download is"
md5sums.exe -u *.zip
echo ""

echo "if the 2 numbers don't match this Virtual Machine"
echo "zip file is corrupt. Redo the download and make sure
echo "the ftp server is set to -binary- transfer"

