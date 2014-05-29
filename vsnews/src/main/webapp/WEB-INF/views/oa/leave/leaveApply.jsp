<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
	<%@ include file="/common/global.jsp"%>
	<%@ include file="/common/meta.jsp" %>
	<title>请假申请</title>
    
    <!-- Bootstrap core CSS -->
    <link href="${ctx }/js/common/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="${ctx }/js/common/bootstrap/css/bootstrap-modal-bs3patch.css" rel="stylesheet" />
    <link href="${ctx }/js/common/bootstrap/css/bootstrap-modal.css" rel="stylesheet" />
    
    <%-- <%@ include file="/common/include-base-styles.jsp" %> --%>
    <%@ include file="/common/include-jquery-ui-theme.jsp" %>
    <link href="${ctx }/js/common/plugins/jquery-ui/extends/timepicker/jquery-ui-timepicker-addon.css" type="text/css" rel="stylesheet" />

    <script src="${ctx }/js/common/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jquery-ui/jquery-ui-${themeVersion }.min.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jquery-ui/extends/timepicker/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/jquery-ui/extends/timepicker/jquery-ui-timepicker-zh-CN.js" type="text/javascript"></script>
    <script type="text/javascript">
	    $(function() {
	    	$('#startTime,#endTime').datetimepicker({
	            stepMinute: 5
	        });
	    });
    </script>
</head>

<body>
	<!-- <div class="container"> -->
	<c:if test="${not empty message}">
		<div id="message" class="alert alert-success">${message}</div>
		<!-- 自动隐藏提示信息 -->
		<script type="text/javascript">
			setTimeout(function() {
				$('#message').hide('slow');
			}, 5000);
		</script>
	</c:if>
	<c:if test="${not empty error}">
		<div id="error" class="alert alert-error">${error}</div>
		<!-- 自动隐藏提示信息 -->
		<script type="text/javascript">
			setTimeout(function() {
				$('#error').hide('slow');
			}, 5000);
		</script>
	</c:if>
	<form:form id="inputForm" action="${ctx}/oa/leave/start" method="post"
		class="well col-md-8">
		<h3>请假申请</h3>
		<hr>

		<div class="row">
		<div class="form-group col-md-8">
			<label for="leaveType">请假类型：</label>
			<div class="controls">
				<select id="leaveType" name="leaveType" class="form-control">
					<option>公休</option>
					<option>病假</option>
					<option>调休</option>
					<option>事假</option>
					<option>婚假</option>
				</select>
			</div>
		</div>
		</div>
		<div class="row">
		<div class="form-group col-md-4">
			<label for="startTime">开始时间：</label> <input type="text"
				id="startTime" name="startTime" class="form-control">
		</div>
		<div class="form-group col-md-4">
			<label for="endTime">结束时间：</label> <input type="text" id="endTime"
				name="endTime" class="form-control">
		</div>
		</div>
		<div class="row">
		<div class="form-group col-md-8">
			<label for="reason">请假原因：</label>
			<textarea id="reason" name="reason" class="form-control" rows="3"></textarea>
		</div>
		</div>
		<div class="row">
		<div class="form-group col-md-4">
			<button type="submit" class="btn btn-default">申请</button>
		</div>
		</div>
	</form:form>
	<!-- </div> -->

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="${ctx }/js/common/bootstrap/js/bootstrap.min.js"></script>
    <script src="${ctx }/js/common/bootstrap/js/bootstrap-modalmanager.js"></script>
    <script src="${ctx }/js/common/bootstrap/js/bootstrap-modal.js"></script>
</body>
</html>
