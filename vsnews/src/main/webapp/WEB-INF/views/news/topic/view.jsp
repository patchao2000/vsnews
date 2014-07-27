<%@ page import="org.activiti.engine.identity.Group" %>
<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-7-18
  Time: 下午5:43
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--@elvariable id="topic" type="com.videostar.vsnews.entity.news.NewsTopic"--%>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <%
        String ctx = request.getContextPath();
        Boolean canDispatch = false;
        List<Group> groupList = (List<Group>) session.getAttribute("groups");
        for (Group group : groupList) {
            if (group.getId().equals("topicDispatch")) {
                canDispatch = true;
                break;
            }
        }
    %>
    <title>查看选题内容</title>
    <%@ include file="/common/allcss.jsp" %>
    <link href="${ctx}/assets/stylesheets/plugins/select2/select2.css" media="all" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/assets/stylesheets/plugins/bootstrap_datetimepicker/bootstrap-datetimepicker.min.css" media="all"
          rel="stylesheet" type="text/css"/>
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
                                查看选题内容
                            </div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content'>
                            <form id="inputForm"
                                    <% if (canDispatch) { %>
                                  action="${ctx}/news/topic/dispatch/${topic.id}/edta"
                                    <% } else { %>
                                  action="#"
                                    <% } %>
                                  class="form form-horizontal"
                                  style="margin-bottom: 0;" method="post" accept-charset="UTF-8">
                                <input name="authenticity_token" type="hidden"/>

                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='title'>标题：</label>

                                    <div class='col-md-10'>
                                        <input class='form-control' id='title' name='title'
                                               type='text' value="${topic.title }" readonly="readonly">
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='reporters'>记者：</label>

                                    <div class='col-md-10'>
                                        <select class='select2 form-control' multiple disabled="disabled"
                                                id="reporters_sel">
                                        </select>
                                        <input type='hidden' id='reporters' name='reporters' value=''>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='cameramen'>摄像员：</label>

                                    <div class='col-md-10'>
                                        <select class='select2 form-control' multiple disabled="disabled"
                                                id="cameramen_sel">
                                        </select>
                                        <input type='hidden' id='cameramen' name='cameramen' value=''>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='others'>其他人员：</label>

                                    <div class='col-md-10'>
                                        <select class='select2 form-control' multiple disabled="disabled"
                                                id="others_sel">
                                        </select>
                                        <input type='hidden' id='others' name='others' value=''>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='interviewTime'>采访时间：</label>

                                    <div class='col-md-4'>
                                        <div class='datetimepicker input-group'>
                                            <fmt:formatDate value="${topic.interviewTime}"
                                                            type="date"
                                                            pattern="yyyy-MM-dd HH:mm"
                                                            var="f_interviewTime"/>
                                            <input class='form-control' id='interviewTime' name='interviewTime'
                                                   type='text' value="${f_interviewTime}" readonly="readonly">
                                            <span class='input-group-addon'>
                                            <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                            </span>
                                        </div>
                                    </div>

                                    <label class='col-md-2 control-label' for='location'>采访地点：</label>

                                    <div class='col-md-4'>
                                        <input class='form-control' id='location' name='location' type='text'
                                               value="${topic.location }" readonly="readonly">
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='startTime'>出发时间：</label>

                                    <div class='col-md-4'>
                                        <div class='datetimepicker input-group'>
                                            <fmt:formatDate value="${topic.startTime}"
                                                            type="date"
                                                            pattern="yyyy-MM-dd HH:mm"
                                                            var="f_startTime"/>
                                            <input class='form-control' id='startTime' name='startTime'
                                                   type='text' value="${f_startTime}" readonly="readonly">
                                <span class='input-group-addon'>
                                <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                </span>
                                        </div>
                                    </div>
                                    <label class='col-md-2 control-label' for='endTime'>返回时间：</label>

                                    <div class='col-md-4'>
                                        <div class='datetimepicker input-group'>
                                            <fmt:formatDate value="${topic.endTime}"
                                                            type="date"
                                                            pattern="yyyy-MM-dd HH:mm"
                                                            var="f_endTime"/>
                                            <input class='form-control' id='endTime' name='endTime'
                                                   type='text' value="${f_endTime}" readonly="readonly">
                                <span class='input-group-addon'>
                                <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                </span>
                                        </div>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='content1'>内容：</label>

                                    <div class='col-md-10'>
                                        <textarea class='form-control' id='content1' name='content'
                                                  rows='5' readonly="readonly">${topic.content }</textarea>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='devices'>所需设备/车辆：</label>

                                    <div class='col-md-10'>
                                        <textarea class='form-control' id='devices' name='devices'
                                                  rows='3' readonly="readonly">${topic.devices }</textarea>
                                    </div>
                                </div>
                                <% if (canDispatch) { %>
                                <c:if test="${topic.status eq 1}">
                                    <div class='form-actions form-actions-padding-sm'>
                                        <div class='row'>
                                            <div class='col-md-10 col-md-offset-2'>
                                                <button class='btn btn-info' type='submit'><i class='icon-save'></i> 派遣
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                                <% } %>
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

<script type="text/javascript">
    function fillSelectControlWithGroup(controlId, groupId) {
        $.getJSON(ctx + '/user/objlist/groupmembers/' + groupId, function (data) {
            var users = '';
            var template = "<option value='#id'>#name</option>";
            $.each(data, function (dk, dv) {
                var curr = template;
                $.each(dv, function (k, v) {
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

    function loadDetail(topicId) {
        $.getJSON(ctx + '/news/topic/detail/' + topicId, function (data) {
            $.each(data, function (k, v) {
                if (k == "reporters")
                    $('#reporters_sel').select2().select2('val', v);
                else if (k == "cameramen")
                    $('#cameramen_sel').select2().select2('val', v);
                else if (k == "others")
                    $('#others_sel').select2().select2('val', v);
            });
        });
    }

    $(function () {
        $.ajaxSettings.async = false;

        fillSelectControlWithGroup('reporters_sel', 'reporter');
        fillSelectControlWithGroup('cameramen_sel', 'cameraman');
        fillSelectControlWithGroup('others_sel', 'stuff');

        loadDetail(${topic.id});

        $.ajaxSettings.async = true;

    });
</script>

</body>
</html>