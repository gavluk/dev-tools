<%@ page import="java.util.Enumeration" %>


<pre>
<%

out.println("\nHEADERS\n=======");

Enumeration<String> headerNames = request.getHeaderNames();
while(headerNames.hasMoreElements()) {
  String headerName = headerNames.nextElement();
  out.println(headerName + ":\t" + request.getHeader(headerName));
}

out.println("\nPARAMS\n=======");
Enumeration<String> params = request.getParameterNames(); 
while(params.hasMoreElements()){
 String paramName = params.nextElement();
 out.println(paramName+":\t"+request.getParameter(paramName));
}

out.println("\nMISC\n=======");
out.println("remote_addr:\t" + request.getRemoteAddr()); 

%>

</pre>
