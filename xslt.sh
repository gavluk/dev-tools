#/bin/sh -X

print_help() {
    echo "Usage: xslt.sh input.xml transform.xslt output.xml"
}

if [ -z $SAXON ] 
then
SAXON=$HOME/opt/saxon
fi

echo "Using Saxon at: "$SAXON

if [ ! -d $SAXON ]; then
>&2 echo "$SAXON not exists" && print_help && exit 1
fi

SAXON_JAR="${SAXON}/saxon9he.jar"

if [ ! -f $SAXON_JAR ]; then
>&2 echo "Cannot find ${SAXON_JAR} file" && exit 1
fi

if [ ! -f $1 ]; then 
>&2 echo "first parameter must be input xml file but '$1' does not exist" && print_help && exit 1
fi

if [ ! -f $2 ]; then 
>&2 echo "second parameter must be xslt file but '$2' does not exist" && print_help && exit 1
fi

# CP=`cygpath -pw "$XALAN/serializer.jar:$XALAN/xalan.jar:$XALAN/xercesImpl.jar:$XALAN/xml-apis.jar"`

#echo $CP

# https://www.saxonica.com/documentation9.5/using-xsl/commandline.html
java -jar $SAXON/saxon9he.jar -s:$1 -xsl:$2 -o:$3