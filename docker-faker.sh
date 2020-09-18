#!/bin/sh +x

docker run --name faker -p 8003:3000 -d rahmatawaludin/faker-server

echo <<EOF
Usage examples
--------------

http://localhost:8003/?property=name.findName
http://localhost:8003/?property=name.firstName
http://localhost:8003/?property=internet.userName
http://localhost:8003/?property=finance.iban
http://localhost:8003/?property=finance.bic
http://localhost:8003/?property=finance.currencyCode
http://localhost:8003/?property=company.companyName
http://localhost:8003/?property=address.streetAddress
http://localhost:8003/?property=address.zipCode
http://localhost:8003/?property=address.city
http://localhost:8003/?property=address.countryCode
http://localhost:8003/?property=internet.exampleEmail
http://localhost:8003/?property=random.uuid
http://localhost:8003/?property=random.number

EOF
