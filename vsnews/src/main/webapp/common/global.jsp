<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,org.apache.commons.lang3.StringUtils,org.apache.commons.lang3.ObjectUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>--%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
    var ctx = '<%=request.getContextPath() %>';
</script>
<%--<%--%>
	<%--//jquery.ui主题--%>
	<%--String defaultTheme = "redmond";--%>
	<%--String themeVersion = "1.10.4";--%>

	<%--session.setAttribute("themeName", defaultTheme);--%>
	<%--session.setAttribute("themeVersion", themeVersion);--%>
	<%--pageContext.setAttribute("timeInMillis", System.currentTimeMillis());--%>
<%--%>--%>

<%--@elvariable id="defaultTheme" type="java.lang.String"--%>
<%--@elvariable id="themeVersion" type="java.lang.String"--%>

<%--@elvariable id="message" type="java.lang.String"--%>
<%--@elvariable id="error" type="java.lang.String"--%>

<c:set var="defbodyclass" value="contrast-fb fixed-header fixed-navigation"/>

<%--@elvariable id="user" type="org.activiti.engine.identity.User"--%>
<% if (!request.getRequestURI().contains("/login")) { %>
<script type="text/javascript">
    var notLogon = ${empty user};
    if (notLogon) {
        location.href = '${ctx}/login?timeout=true';	//	jump to login
    }
</script>
<% } %>
