#/bin/sh -X

SAXON=`cygpath -w "D:\opt\SaxonHE9-9-0-2J"`
echo "Using Saxon at: "$SAXON

# CP=`cygpath -pw "$XALAN/serializer.jar:$XALAN/xalan.jar:$XALAN/xercesImpl.jar:$XALAN/xml-apis.jar"`

#echo $CP

# https://www.saxonica.com/documentation9.5/using-xsl/commandline.html
java -jar $SAXON/saxon9he.jar -s:$1 -xsl:$2 -o:$3

