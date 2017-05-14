# http://stackoverflow.com/questions/11929461/how-can-i-run-dos2unix-on-an-entire-directory
# Uses -P processors to dos2unix everything
find . -type f -print0 | xargs -0 -n 1 -P 1 dos2unix
