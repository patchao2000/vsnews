<%@page import="com.videostar.vsnews.util.PropertyFileUtil"%>
<%@page import="org.springframework.beans.factory.config.PropertiesFactoryBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	PropertyFileUtil.init();
%>
<html lang="en">
<head>
	<%@ include file="/common/global.jsp"%>
	<script>
		var notLogon = ${empty user};
		if (notLogon) {
			location.href = '${ctx}/login?timeout=true';	//	jump to login
		}
	</script>
	<%@ include file="/common/meta.jsp" %>
    <title>VSNews</title>
    
    <!-- Bootstrap core CSS -->
    <link href="${ctx }/js/common/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="${ctx }/js/common/bootstrap/css/bootstrap-modal-bs3patch.css" rel="stylesheet" />
    <link href="${ctx }/js/common/bootstrap/css/bootstrap-modal.css" rel="stylesheet" />
    
    <%@ include file="/common/include-base-styles.jsp" %>
	<%@ include file="/common/include-jquery-ui-theme.jsp" %>
    <link rel="stylesheet" type="text/css" href="${ctx }/css/menu.css" />
    <%@ include file="/common/include-custom-styles.jsp" %>
	<link href="${ctx }/css/main.css" type="text/css" rel="stylesheet"/>
	<style type="text/css">
	.ui-tabs-panel {height: 100%; width: 100%;}
	.ui-tabs .ui-tabs-nav li a {padding-right: .5em;}
	#tabs li .ui-icon-close { float: left; margin: 0.5em 0.2em 0 0; cursor: pointer; }
	#add_tab { cursor: pointer; }
	</style>

    <script src="${ctx }/js/common/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/plugins/jquery-ui/jquery-ui-${themeVersion }.min.js" type="text/javascript"></script>
	<script src="${ctx }/js/common/plugins/jquery-ui/extends/layout/jquery.layout.min.js?v=1.3" type="text/javascript"></script>
	<script src='${ctx }/js/common/common.js' type="text/javascript"></script>
    <script src='${ctx }/js/module/main/mainframe.js' type="text/javascript"></script>

	<script type="text/javascript">
    $(function() {
    	$('#loginOut').click(function(){
    		if (confirm('系统提示，您确定要退出本次登录吗?')) {
    			location.href = ctx + '/user/logout';
    		}
    	});
      });
	</script>
</head>

<body>
	<!-- #TopPane -->
	<div id="topPane"
		class="ui-layout-north ui-widget ui-widget-header ui-widget-content">
		<div style="padding-left: 5px; font-size: 16px; margin-top: 1px;">
			<table id="topTable"
				style="padding: 0px; margin: 0px; margin-top: -5px; width: 100%">
				<tr>
					<td>
						<!--  width="40px"> --> <%-- <img src="${ctx }/images/logo.png" align="top"  style="margin-top:5px" /> --%>
						<span style="font-size: 17px; color: #FFFFFF">Videostar </span>
					</td>
					<td><span style="font-size: 17px; color: #FFFFFF">VSNews</span><br />
					</td>
					<td>
						<div
							style="float: right; color: #fff; font-size: 12px; margin-top: 2px">
							<div>
								<label for="username">欢迎：</label> <span
									title="角色：${groupNames }">${user.firstName }
									${user.lastName }/${user.id }</span>
							</div>
							<div style="text-align: right;">
								<!-- <a id="chang-theme" href="#">切换风格</a> -->
								<a href="#" id="loginOut">安全退出</a>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<!-- #LeftPane -->
	<div id="leftPane" class="ui-layout-west ui-widget ui-widget-content">
		<div id="navimenu" class="list-group">
			<a rel="main/welcome" href="#" class="list-group-item active">首页</a>
			<a rel="oa/leave/apply" href="#" class="list-group-item">请假申请</a>
			<a rel="oa/leave/list/task" href="#" class="list-group-item">请假办理</a>
            <a rel="oa/leave/list/running" href="#" class="list-group-item">运行中流程</a>
            <a rel="oa/leave/list/finished" href="#" class="list-group-item">已结束流程</a>
            <a rel="news/topic/apply" href="#" class="list-group-item">新建选题</a>
            <a rel="news/list/task" href="#" class="list-group-item">待办任务</a>
            <a rel="news/list/running" href="#" class="list-group-item">运行中流程</a>
		</div>
	</div>

	<!-- RightPane -->
	<div id="centerPane"
		class="ui-layout-center ui-helper-reset ui-widget-content">
		<div id="tabs">
			<ul>
				<li><a class="tabs-title" href="#tab-index">首页</a><span class='ui-icon ui-icon-close' title='关闭标签页'></span></li>
			</ul>
			<div id="tab-index">
				<!-- <iframe id="mainIframe" name="mainIframe" src="welcome" class="module-iframe" scrolling="auto" frameborder="0" style="width:100%;height:100%;"></iframe> -->
				<iframe id="mainIframe" name="mainIframe" src="welcome" class="module-iframe" seamless style="width:100%;height:100%;"></iframe>
			</div>
		</div>
	</div>

	<!-- #BottomPane -->
	<div id="bottomPane"
		class="ui-layout-south ui-widget ui-widget-content">
		<div class="footer ui-state-default">
			<a href="http://www.videostar.com" target="_blank">Videostar</a> <span
				class="copyright">©2014</span> <span class="version">Version：${prop['system.version']}</span>
		</div>
	</div>
 
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="${ctx }/js/common/bootstrap/js/bootstrap.min.js"></script>
    <script src="${ctx }/js/common/bootstrap/js/bootstrap-modalmanager.js"></script>
    <script src="${ctx }/js/common/bootstrap/js/bootstrap-modal.js"></script>
</body>
</html>
