#!/bin/sh 

FILES=`find -name "*.ts" | wc -l`
TESTS=`find -name "*.ts" | grep "src/test" | wc -l`

LINES=`find -name "*.ts" | xargs wc -l | awk '/total/{k+=$1}END{print k}';`
TESTS_LINES=`find -name "*.ts" | grep "src/test" | xargs wc -l | awk '/total/{k+=$1}END{print k}';`

RETURN_NULL=`find -name "*.ts" | xargs grep "return null" | wc -l`

PERCENT=100
TEN_KILO=10000


echo "${LINES} lines of code in ${FILES} files: $(expr $LINES / $FILES) lines per class"

if [ $TESTS -eq "0" ]; 
then
    echo "ZERO TESTS!"
else 
    echo "${TESTS_LINES} lines of tests in ${TESTS} files: $(expr $TESTS_LINES / $TESTS) lines per test"
    echo "$(expr $PERCENT \* $TESTS / $(expr $FILES - $TESTS))% Test / Class coverage"
    echo "$(expr $PERCENT \* $TESTS_LINES / $(expr $LINES - $TESTS_LINES))% Test line / Class line coverage"
fi

echo "${RETURN_NULL} 'return null' antipatterns found: it's $(expr $TEN_KILO \* $RETURN_NULL / $LINES) per 10 000 lines"