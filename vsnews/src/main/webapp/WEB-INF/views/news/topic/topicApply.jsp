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
    <%@ include file="/common/allcss.jsp" %>
</head>

<body class='${defbodyclass}'>
<%@ include file="/common/header.jsp" %>

<div id='wrapper'>
    <%@ include file="/common/nav.jsp" %>
    <section id='content'>
        <div class='container'>
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

            <div class='row'>
                <div class='col-sm-12'>
                    <div class='box'>
                        <div class='box-header blue-background'>
                            <div class='title'>
                                <div class='icon-edit'></div>
                                <%=mainTitle%>
                            </div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content'>
                            <form id="inputForm" action="<%=action%>" class="form form-horizontal" style="margin-bottom: 0;" method="post" accept-charset="UTF-8">
                                <input name="authenticity_token" type="hidden" />
                                <% if (reApplyMode && !modifyDeviceOnly) { %>
                                <div class='form-group has-error'>
                                    <label class='col-md-2 control-label' for='leaderbackreason'>领导批示：</label>
                                    <div class='col-md-5'>
                                        <input class='form-control' id='leaderbackreason' name='leaderbackreason' type='text' readonly="readonly">
                                    </div>
                                </div>
                                <% } %>
                                <% if (reApplyMode && modifyDeviceOnly) { %>
                                <div class='form-group has-error'>
                                    <label class='col-md-2 control-label' for='devicebackreason'>设备部门批示：</label>
                                    <div class='col-md-5'>
                                        <input class='form-control' id='devicebackreason' name='devicebackreason' type='text' readonly="readonly">
                                    </div>
                                </div>
                                <% } %>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='title'>标题：</label>
                                    <div class='col-md-5'>
                                        <input class='form-control' id='title' name='title' placeholder='标题' type='text' <%=readonly%>>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='content1'>内容：</label>
                                    <div class='col-md-5'>
                                        <textarea class='form-control' id='content1' name = 'content' placeholder='内容' rows='5' <%=readonly%>></textarea>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='devices'>需要设备：</label>
                                    <div class='col-md-5'>
                                        <textarea class='form-control' id='devices' name='devices' placeholder='需要设备' rows='3'></textarea>
                                    </div>
                                </div>
                                <div class='form-actions form-actions-padding-sm'>
                                    <div class='row'>
                                        <div class='col-md-10 col-md-offset-2'>
                                            <button class='btn btn-primary' type='submit'>
                                                <i class='icon-save'></i>
                                                提交
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<%@ include file="/common/alljs.jsp" %>
<% if (reApplyMode) { %>
<script type="text/javascript">
    var taskid = '<%=request.getParameter("taskid") %>';
    var topicid = '<%=request.getParameter("id") %>';

//    function closeTab() {
//        window.parent.closeIframeTab(window.parent.getIframeByElement(document.body).id);
//    }

    function loadDetailWithTaskVars(topicId, taskId, callback) {
        $.getJSON(ctx + '/news/topic/detail-with-vars/' + topicId + "/" + taskId, function(data) {
            $.each(data, function(k, v) {
                if (k == "content")
                    $("#content1").val(v);
                else
                    $("#" + k).val(v);
            });
            if ($.isFunction(callback)) {
                callback(data);
            }
        });
    }

    $(function () {
        loadDetailWithTaskVars(topicid, taskid, function(data) {
            $("#leaderbackreason").val(data.variables.leaderBackReason);
            $("#devicebackreason").val(data.variables.deviceBackReason);
        });
        $( "#inputForm" ).submit(function( event ) {
            var keys = "title,content,devices", types = "S,S,S";
            var values = $('#title').val() + ',' + $('#content1').val() + ',' + $('#devices').val();
            $.post(ctx + '/news/topic/complete/' + taskid, {
                keys: keys,
                values: values,
                types: types
            }, function(resp) {
                if (resp == 'success') {
                    alert('任务完成');
                    location.href = ctx + '/news/topic/list/task'
                } else {
                    alert('操作失败!');
                }
            });

            event.preventDefault();
        });
    });
</script>
<% } %>
</body>
</html>
