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
        String mainTitle = "撰写选题";
        String readonly="";

        boolean newMode = true;
        boolean reApplyMode = false, modifyDeviceOnly = false;
        if (paraReApply != null && paraReApply.equals("true")) {
            newMode = false;

            mainTitle = "调整选题内容";
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
    <link href="${ctx}/assets/stylesheets/plugins/select2/select2.css" media="all" rel="stylesheet" type="text/css" />
    <link href="${ctx}/assets/stylesheets/plugins/bootstrap_datetimepicker/bootstrap-datetimepicker.min.css" media="all" rel="stylesheet" type="text/css" />
</head>

<body class='${defbodyclass}'>
<%@ include file="/common/header.jsp" %>

<div id='wrapper'>
    <%@ include file="/common/nav.jsp" %>
    <section id='content'>
        <div class='container'>
            <%@ include file="/common/message-error.jsp" %>

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
                                    <div class='col-md-10'>
                                        <input class='form-control' id='leaderbackreason' name='leaderbackreason' type='text' readonly="readonly">
                                    </div>
                                </div>
                                <% } %>
                                <% if (reApplyMode && modifyDeviceOnly) { %>
                                <div class='form-group has-error'>
                                    <label class='col-md-2 control-label' for='devicebackreason'>设备部门批示：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='devicebackreason' name='devicebackreason' type='text' readonly="readonly">
                                    </div>
                                </div>
                                <% } %>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='title'>标题：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='title' name='title' placeholder='标题' type='text' <%=readonly%>>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='reporters'>记者：</label>
                                    <div class='col-md-10'>
                                        <select class='select2 form-control' multiple placeholder='点击选择记者' id="reporters_sel">
                                        </select>
                                        <input type='hidden' id='reporters' name='reporters' value=''>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='cameramans'>摄像员：</label>
                                    <div class='col-md-10'>
                                        <select class='select2 form-control' multiple placeholder='点击选择摄像员' id="cameramans_sel">
                                        </select>
                                        <input type='hidden' id='cameramans' name='cameramans' value=''>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='others'>其他人员：</label>
                                    <div class='col-md-10'>
                                        <select class='select2 form-control' multiple placeholder='点击选择其他人员' id="others_sel">
                                        </select>
                                        <input type='hidden' id='others' name='others' value=''>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='interviewtime'>采访时间：</label>
                                    <div class='col-md-4'>
                                        <div class='datetimepicker input-group'>
                                            <input class='form-control' id='interviewtime' name='interviewtime' placeholder='请选择时间' type='text'>
                                            <span class='input-group-addon'>
                                                <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                            </span>
                                        </div>
                                    </div>
                                    
                                    <label class='col-md-2 control-label' for='interviewlocation'>采访地点：</label>
                                    <div class='col-md-4'>
                                        <input class='form-control' id='interviewlocation' name='interviewlocation' type='text'>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='starttime'>出发时间：</label>
                                    <div class='col-md-4'>
                                        <div class='datetimepicker input-group'>
                                            <input class='form-control' id='starttime' name='starttime' placeholder='请选择时间' type='text'>
                                            <span class='input-group-addon'>
                                                <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                            </span>
                                        </div>
                                    </div>
                                    <label class='col-md-2 control-label' for='endtime'>返回时间：</label>
                                    <div class='col-md-4'>
                                        <div class='datetimepicker input-group'>
                                            <input class='form-control' id='endtime' name='endtime' placeholder='请选择时间' type='text'>
                                            <span class='input-group-addon'>
                                                <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='content1'>内容：</label>
                                    <div class='col-md-10'>
                                        <textarea class='form-control ckeditor' id='content1' name = 'content' placeholder='内容' rows='5' <%=readonly%>></textarea>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='devices'>所需设备/车辆：</label>
                                    <div class='col-md-10'>
                                        <textarea class='form-control' id='devices' name='devices' placeholder='所需设备/车辆' rows='3'></textarea>
                                    </div>
                                </div>
                                <div class='form-actions form-actions-padding-sm'>
                                    <div class='row'>
                                        <div class='col-md-10 col-md-offset-2'>
                                            <button class='btn btn-primary' type='submit'><i class='icon-save'></i> 提交</button>
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
<script src="${ctx}/assets/javascripts/plugins/ckeditor/ckeditor.js" type="text/javascript"></script>
<script src="${ctx}/assets/javascripts/plugins/select2/select2.js" type="text/javascript"></script>
<script src="${ctx}/assets/javascripts/plugins/bootstrap_datetimepicker/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script type="text/javascript">
    $('.datetimepicker').datetimepicker({
        format: 'yyyy-MM-dd hh:mm',
        language: 'ch',
        pickDate: true,
        pickTime: true,
        hourStep: 1,
        minuteStep: 15,
        secondStep: 30,
        inputMask: true
    });
</script>

<script type="text/javascript">
    function fillSelectControlWithGroup(controlId, groupId) {
        $.getJSON(ctx + '/user/objlist/groupmembers/' + groupId, function(data) {
            var users = '';
            var template = "<option value='#id'>#name</option>";
            $.each(data, function(dk, dv) {
                var curr = template;
                $.each(dv, function(k, v) {
                    if (k == 'userId') {
                        curr = curr.replace(/#id/g, v);
                    }
                    else if (k == 'firstName') {
                        curr = curr.replace(/#name/g, v);
                    }
                });
                users += curr;
            });
            $('#' + controlId).html(users);
        });
    }

    function makeMultiSelectValues(controlId, fieldName) {
        var index = 0;
        $.each(
            $('#' + controlId + ' :selected'), function () {
                var input = $('<input>');
                input.attr("name", fieldName + "[" + index + "]");
                input.attr("type", "hidden");
                input.attr("value", $(this).val());
                $('#' + controlId).append(input);
                index++;
            }
        );
    }

    var contentLength = 0;

    $(function () {
        fillSelectControlWithGroup('reporters_sel', 'reporter');
        fillSelectControlWithGroup('cameramans', 'cameraman');
        fillSelectControlWithGroup('others', 'stuff');

        //  ckeditor采取异步方式setData, 以下函数可以在提交时正确得到ckeditor数据
        function ckupdate() {
            for (instance in CKEDITOR.instances)
                CKEDITOR.instances[instance].updateElement();
        }

        $("#inputForm").submit(function(event) {
            ckupdate();

            if ($('#title').val().length == 0) {
                alert('标题不能为空！');
                event.preventDefault();
                return;
            }
            if ($('#content1').val().length == 0) {
                alert('内容不能为空！');
                event.preventDefault();
                return;
            }

            makeMultiSelectValues('reporters_sel', 'reporters');
            makeMultiSelectValues('cameramans_sel', 'cameramans');
            makeMultiSelectValues('others_sel', 'others');
        });

    });
</script>

<%--<% if (reApplyMode) { %>--%>
<%--<script type="text/javascript">--%>
    <%--var taskid = '<%=request.getParameter("taskid") %>';--%>
    <%--var topicid = '<%=request.getParameter("id") %>';--%>

    <%--function loadDetailWithTaskVars(topicId, taskId, callback) {--%>
        <%--$.getJSON(ctx + '/news/topic/detail-with-vars/' + topicId + "/" + taskId, function(data) {--%>
            <%--$.each(data, function(k, v) {--%>
                <%--if (k == "content")--%>
                    <%--$("#content1").val(v);--%>
                <%--else--%>
                    <%--$("#" + k).val(v);--%>
            <%--});--%>
            <%--if ($.isFunction(callback)) {--%>
                <%--callback(data);--%>
            <%--}--%>
        <%--});--%>
    <%--}--%>

    <%--$(function () {--%>
        <%--loadDetailWithTaskVars(topicid, taskid, function(data) {--%>
            <%--$("#leaderbackreason").val(data.variables.leaderBackReason);--%>
            <%--$("#devicebackreason").val(data.variables.deviceBackReason);--%>
        <%--});--%>
        <%--$( "#inputForm" ).submit(function( event ) {--%>
            <%--var keys = "title,content,devices", types = "S,S,S";--%>
            <%--var values = $('#title').val() + ',' + $('#content1').val() + ',' + $('#devices').val();--%>
            <%--$.post(ctx + '/news/topic/complete/' + taskid, {--%>
                <%--keys: keys,--%>
                <%--values: values,--%>
                <%--types: types--%>
            <%--}, function(resp) {--%>
                <%--if (resp == 'success') {--%>
                    <%--alert('任务完成');--%>
                    <%--location.href = ctx + '/news/topic/list/task'--%>
                <%--} else {--%>
                    <%--alert('操作失败!');--%>
                <%--}--%>
            <%--});--%>

            <%--event.preventDefault();--%>
        <%--});--%>
    <%--});--%>
<%--</script>--%>
<%--<% } %>--%>
</body>
</html>
