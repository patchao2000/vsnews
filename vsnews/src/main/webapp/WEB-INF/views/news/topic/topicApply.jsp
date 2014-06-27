<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-6-4
  Time: 下午5:52
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <%
        String paraReApply = request.getParameter("reapply");
        String paraDeviceOnly = request.getParameter("devonly");
        String ctx = request.getContextPath();
        String action = ctx + "/news/topic/start";
        String mainTitle = "创建选题";
        String readonly="";
        boolean reApplyMode = false, modifyDeviceOnly = false;
        if (paraReApply != null && paraReApply.equals("true")) {
            mainTitle = "调整申请内容";
            reApplyMode = true;
            action = "#";
            if (paraDeviceOnly != null && paraDeviceOnly.equals("true")) {
                modifyDeviceOnly = true;
                readonly = "readonly=\"readonly\"";
            }
        }
    %>
    <title><%=mainTitle%></title>

    <link href="${ctx }/js/common/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <script src="${ctx }/js/common/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/bootstrap/js/bootstrap.min.js"></script>

    <% if (reApplyMode) { %>
        <script type="text/javascript">
            var taskid = '<%=request.getParameter("taskid") %>';
            var topicid = '<%=request.getParameter("id") %>';

            function closeTab() {
                window.parent.closeIframeTab(window.parent.getIframeByElement(document.body).id);
            }

            function loadDetailWithTaskVars(topicId, taskId, callback) {
                $.getJSON(ctx + '/news/topic/detail-with-vars/' + topicId + "/" + taskId, function(data) {
                    $.each(data, function(k, v) {
                        $("#" + k).text(v);
                    });
                    if ($.isFunction(callback)) {
                        callback(data);
                    }
                });
            }

            $(function () {
                loadDetailWithTaskVars(topicid, taskid, function(data) {
                    $("#leaderbackreason").text(data.variables.leaderBackReason);
                    $("#devicebackreason").text(data.variables.deviceBackReason);
                });
                $( "#inputForm" ).submit(function( event ) {
                    var keys = "title,content,devices", types = "S,S,S";
                    var values = $('#title').val() + ',' + $('#content').val() + ',' + $('#devices').val();
                    $.post(ctx + '/news/topic/complete/' + taskid, {
                        keys: keys,
                        values: values,
                        types: types
                    }, function(resp) {
                        if (resp == 'success') {
                            alert('任务完成');
                            closeTab();
                            //location.reload();
                        } else {
                            alert('操作失败!');
                        }
                    });

                    event.preventDefault();
                });
            });
        </script>
    <% } %>
</head>

<body>
<!-- <div class="container"> -->
<c:if test="${not empty message}">
    <div id="message" class="alert alert-success">${message}</div>
    <!-- 自动隐藏提示信息 -->
    <script type="text/javascript">
        setTimeout(function () {
            $('#message').hide('slow');
        }, 5000);
    </script>
</c:if>
<c:if test="${not empty error}">
    <div id="error" class="alert alert-error">${error}</div>
    <!-- 自动隐藏提示信息 -->
    <script type="text/javascript">
        setTimeout(function () {
            $('#error').hide('slow');
        }, 5000);
    </script>
</c:if>
<form:form id="inputForm" action="<%=action%>" method="post" class="well col-md-8">
    <h3><%=mainTitle%></h3>
    <hr>
    <% if (reApplyMode && !modifyDeviceOnly) { %>
    <div class="row">
        <div class="form-group col-md-8 has-error">
            <label for="title">领导批示：</label>
            <textarea id="leaderbackreason" name="leaderbackreason" class="form-control" rows="1" readonly="readonly"></textarea>
        </div>
    </div>
    <% } %>
    <% if (reApplyMode && modifyDeviceOnly) { %>
    <div class="row">
        <div class="form-group col-md-8 has-error">
            <label for="title">设备部门批示：</label>
            <textarea id="devicebackreason" name="devicebackreason" class="form-control" rows="1" readonly="readonly"></textarea>
        </div>
    </div>
    <% } %>
    <div class="row">
        <div class="form-group col-md-8">
            <label for="title">标题：</label>
            <textarea id="title" name="title" class="form-control" rows="1" <%=readonly%>></textarea>
        </div>
    </div>
    <div class="row">
        <div class="form-group col-md-8">
            <label for="content">内容：</label>
            <textarea id="content" name="content" class="form-control" rows="5" <%=readonly%>></textarea>
        </div>
    </div>
    <div class="row">
        <div class="form-group col-md-8">
            <label for="devices">需要设备：</label>
            <textarea id="devices" name="devices" class="form-control" rows="3"></textarea>
        </div>
    </div>
    <div class="row">
        <div class="form-group col-md-4">
            <button type="submit" class="btn btn-default">提交</button>
        </div>
    </div>
</form:form>
<!-- </div> -->
</body>
</html>
