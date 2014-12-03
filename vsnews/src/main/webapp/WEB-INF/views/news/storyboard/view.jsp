<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-9-23
  Time: 下午3:15
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--@elvariable id="storyboard" type="com.videostar.vsnews.entity.news.NewsStoryboard"--%>
<%--@elvariable id="title" type="java.lang.String"--%>
<%--@elvariable id="readonly" type="java.lang.Boolean"--%>
<%--@elvariable id="createMode" type="java.lang.Boolean"--%>
<%--@elvariable id="reapplyMode" type="java.lang.Boolean"--%>
<%--@elvariable id="templates" type="java.util.List"--%>
<%--@elvariable id="auditMode" type="java.lang.Boolean"--%>
<%--@elvariable id="taskId" type="java.lang.String"--%>
<%--@elvariable id="list" type="java.util.List"--%>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>${title}</title>
    <%@ include file="/common/allcss.jsp" %>
    <link rel='stylesheet' href='${ctx}/assets/javascripts/plugins/fullcalendar/fullcalendar-2.2.3/fullcalendar.css' />
    <style>
        .help-block { color: #ff0000; }
    </style>
    <c:set var="action" value="#" />
    <c:if test="${createMode == true}">
        <c:set var="action" value="${ctx}/news/storyboard/save-list"/>
    </c:if>
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
                                ${title}
                            </div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content'>
                            <form:form modelAttribute="storyboard" id="inputForm" action="${action}" class="form form-horizontal"
                                       style="margin-bottom: 0;" method="post" accept-charset="UTF-8">

                                <c:if test="${reapplyMode == true}">
                                    <div class='form-group has-error'>
                                        <label class='col-md-2 control-label' for='leaderbackreason'>审核意见：</label>
                                        <div class='col-md-10'>
                                            <input class='form-control' id='leaderbackreason' name='leaderbackreason' type='text' readonly="readonly">
                                        </div>
                                    </div>
                                </c:if>

                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_templateId'>模板：</label>
                                    <div class='col-md-4'>
                                        <form:select class='select2 form-control' id="storyboard_templateId" path="templateId">
                                            <form:options items="${templates}" itemValue="id" itemLabel="title" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_airDate'>播出时间：</label>
                                    <div class='col-md-4'>
                                        <div class='datepicker input-group' id="storyboard_airDate_picker">
                                            <form:input class='form-control' id='storyboard_airDate' path='airDate' type='text' readonly="${readonly}" />
                                            <span class='input-group-addon'>
                                                <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <hr class='hr-normal'>
                                <c:if test="${auditMode == true}">
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_auditOpinion'>审核意见：</label>
                                    <div class='col-md-10'>
                                        <form:textarea class='form-control' id='storyboard_auditOpinion' path='auditOpinion' />
                                    </div>
                                </div>
                                <input type="hidden" name="submit_type" value="" id="submit-type"/>
                                </c:if>
                                <%--<c:if test="${auditMode == true}">--%>
                                    <%--<div class='form-group'>--%>
                                        <%--<label class='col-md-2 control-label' for='opinion'>审核意见：</label>--%>
                                        <%--<div class='col-md-10'>--%>
                                            <%--<input class='form-control' id='opinion' name='opinion' placeholder='审核意见' type='text'>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                    <%--<input type="hidden" name="submit_type" value="" id="submit-type"/>--%>
                                <%--</c:if>--%>
                                <div class='form-actions form-actions-padding-sm'>
                                    <div class='row'>
                                        <div class='col-md-10 col-md-offset-2'>
                                            <c:if test="${createMode == true || reapplyMode == true}">
                                                <button class='btn btn-primary' type='submit'><i class='icon-save'></i>提交</button>
                                            </c:if>
                                            <c:if test="${auditMode == true}">
                                                <button class='btn btn-primary' type='submit' id="auditPass"><i class='icon-ok'></i>同意</button>
                                                <button class='btn btn-danger' type='submit' id="auditReject"><i class='icon-remove'></i>驳回</button>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>

            <c:if test="${createMode == true}">
            <div class='row'>
                <div class='col-sm-9'>
                    <div class='box'>
                        <div class='box-header'>
                            <div class='title'>播出时间表</div>
                        </div>
                        <div class='box-content'>
                            <div id='calendar'></div>
                        </div>
                    </div>
                </div>
            </div>
            </c:if>
        </div>
    </section>
</div>

<c:if test="${createMode == true}">
<div class="modal fade group-dialog" id="storyboardModal" tabindex="-1" role="dialog" aria-labelledby="storyboardModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="storyboardModalLabel">创建串联单</h4>
            </div>
            <div class="modal-body">
                <label for='sm_template'>模板：</label>
                <select class='form-control' id="sm_template">
                </select>
                <label for='sm_airDate'>播出时间：</label>
                <%--<input class='form-control' name="airDate" id="sm_airDate">--%>
                <div class='datepicker input-group' id="sm_airDate_picker">
                    <input class='form-control' id='sm_airDate' type='text' />
                        <span class='input-group-addon'>
                            <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                        </span>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save_storyboard"><i class='icon-save'></i> 保存</button>
            </div>
        </div>
    </div>
</div>
</c:if>

<%@ include file="/common/alljs.jsp" %>
<script src="${ctx}/assets/javascripts/plugins/fullcalendar/fullcalendar-2.2.3/lib/moment.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/javascripts/plugins/fullcalendar/fullcalendar-2.2.3/fullcalendar.js" type="text/javascript"></script>
<script src="${ctx}/assets/javascripts/plugins/fullcalendar/fullcalendar-2.2.3/lang-all.js" type="text/javascript"></script>

<script type="text/javascript">
    <%--@elvariable id="detail" type="com.videostar.vsnews.web.news.StoryboardTaskDetail"--%>
    <c:if test="${createMode == true}">
    function renderCalendar() {
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
//            defaultDate: '2014-11-12',
            lang: 'zh-cn',
            buttonIcons: false, // show the prev/next text
            weekNumbers: true,
            editable: true,
            eventLimit: true, // allow "more" link when too many events
            events: [
                <c:forEach items="${list }" var="detail">
                    {
                        title: '${detail.title}',
                        start: '<fmt:formatDate value="${detail.storyboard.airDate}" pattern="yyyy-MM-dd" />',
                        <c:choose>
                        <c:when test="${detail.storyboard.status == 2}">color: 'green'</c:when>
                        <c:otherwise>color: 'red'</c:otherwise>
                        </c:choose>
                    },
                </c:forEach>
            ],
            dayClick: function(date, jsEvent, view) {
//                alert('a day has been clicked!');
//                alert(date.format());
                $('#sm_airDate').val(date.format());
                $('#storyboardModal').modal('toggle');
            }
        });
    }

    <%--@elvariable id="template" type="com.videostar.vsnews.entity.news.NewsStoryboardTemplate"--%>
    function fillTemplates() {
        var titles = [], ids = [], i = 0;
        <c:forEach items="${templates}" var="template">
        titles[i] = '${template.title }';
        ids[i++] = '${template.id }';
        </c:forEach>

        var control = $('#sm_template');
        control.empty();
        var content = '', found = false;
        for (var j = 0; j < ids.length; j++)
        {
            var add_content = '<option value="'+ids[j]+'">'+titles[j]+'</option>';
            var add_selected_content = '<option value="'+ids[j]+'" selected="selected">'+titles[j]+'</option>';
            if (j == 0) {
                content = content + add_selected_content;
            }
            else {
                content = content + add_content;
            }
        }
        control.html(content);
        control.select2();
    }

    $('#save_storyboard').click(function () {
        $.ajax({
            type: 'post',
            async: true,
            url: ctx + '/news/storyboard/save-list-args/' + $('#sm_template').val() +'/' + $('#sm_airDate').val(),
            contentType: "application/json; charset=utf-8",
//            data : JSON.stringify(map),
            success: function (resp) {
                if (resp == 'success') {
                    alert('任务完成');
                    location.href = ctx + '${ctx}/news/storyboard/apply-list';
                } else {
                    alert('操作失败!');
                }
            },
            error: function () {
                alert('操作失败!!');
            }
        });

        <%--$.post(ctx + '/news/storyboard/save-list-args/' + $('#sm_template').val(),--%>
                        <%--//+'/' + $('#sm_airDate').val(),--%>
                <%--function (resp) {--%>
                    <%--if (resp == 'success') {--%>
                        <%--alert('任务完成');--%>
                        <%--location.href = ctx + '${ctx}/news/storyboard/apply-list';--%>
                    <%--} else {--%>
                        <%--alert('操作失败!');--%>
                    <%--}--%>
                <%--});--%>
    });
    </c:if>

    $(function () {
        <c:if test="${readonly == true}">
        $("#storyboard_templateId").select2("readonly", true);
        </c:if>

        <c:if test="${createMode == true}">
        renderCalendar();
        fillTemplates();
        </c:if>
    });

</script>

</body>
</html>