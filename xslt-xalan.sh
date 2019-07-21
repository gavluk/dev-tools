#/bin/sh -X

# XALAN env variable must be here
# XALAN="/d/opt/xalan-j_2_7_2"

# If cygwin used:
# CP=`cygpath -pw "$XALAN/serializer.jar:$XALAN/xalan.jar:$XALAN/xercesImpl.jar:$XALAN/xml-apis.jar"`
CP="$XALAN/serializer.jar:$XALAN/xalan.jar:$XALAN/xercesImpl.jar:$XALAN/xml-apis.jar"

echo "Using classpath: $CP"

java -cp "$CP" \
org.apache.xalan.xslt.Process \
-in $1 \
-xsl $2 \
-out $3
