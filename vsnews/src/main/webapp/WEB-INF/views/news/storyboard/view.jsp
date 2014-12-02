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
        </div>
    </section>
</div>
<%@ include file="/common/alljs.jsp" %>
<script src="${ctx}/assets/javascripts/plugins/fullcalendar/fullcalendar-2.2.3/lib/moment.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/javascripts/plugins/fullcalendar/fullcalendar-2.2.3/fullcalendar.js" type="text/javascript"></script>
<script src="${ctx}/assets/javascripts/plugins/fullcalendar/fullcalendar-2.2.3/lang-all.js" type="text/javascript"></script>

<script type="text/javascript">

    function renderCalendar() {
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            defaultDate: '2014-11-12',
            lang: 'zh-cn',
            buttonIcons: false, // show the prev/next text
            weekNumbers: true,
            editable: true,
            eventLimit: true, // allow "more" link when too many events
            events: [
                {
                    title: 'All Day Event',
                    start: '2014-11-01'
                },
                {
                    title: 'Long Event',
                    start: '2014-11-07',
                    end: '2014-11-10'
                },
                {
                    id: 999,
                    title: 'Repeating Event',
                    start: '2014-11-09T16:00:00'
                },
                {
                    id: 999,
                    title: 'Repeating Event',
                    start: '2014-11-16T16:00:00'
                },
                {
                    title: 'Conference',
                    start: '2014-11-11',
                    end: '2014-11-13'
                },
                {
                    title: 'Meeting',
                    start: '2014-11-12T10:30:00',
                    end: '2014-11-12T12:30:00'
                },
                {
                    title: 'Lunch',
                    start: '2014-11-12T12:00:00'
                },
                {
                    title: 'Meeting',
                    start: '2014-11-12T14:30:00'
                },
                {
                    title: 'Happy Hour',
                    start: '2014-11-12T17:30:00'
                },
                {
                    title: 'Dinner',
                    start: '2014-11-12T20:00:00'
                },
                {
                    title: 'Birthday Party',
                    start: '2014-11-13T07:00:00'
                },
                {
                    title: 'Click for Google',
                    url: 'http://google.com/',
                    start: '2014-11-28'
                }
            ]
        });
    }


    $(function () {
        <c:if test="${readonly == true}">
        $("#storyboard_templateId").select2("readonly", true);
        </c:if>

        renderCalendar();
    });

</script>

</body>
</html>