<%--<%@ page import="org.activiti.engine.identity.Group" %>--%>
<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-7-18
  Time: 下午5:43
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--@elvariable id="topic" type="com.videostar.vsnews.entity.news.NewsTopic"--%>
<%--@elvariable id="title" type="java.lang.String"--%>
<%--@elvariable id="reporters" type="java.util.List"--%>
<%--@elvariable id="cameramen" type="java.util.List"--%>
<%--@elvariable id="others" type="java.util.List"--%>
<%--@elvariable id="readonly" type="java.lang.Boolean"--%>
<%--@elvariable id="createMode" type="java.lang.Boolean"--%>
<%--@elvariable id="auditMode" type="java.lang.Boolean"--%>
<%--@elvariable id="auditDeviceMode" type="java.lang.Boolean"--%>
<%--@elvariable id="reapplyMode" type="java.lang.Boolean"--%>
<%--@elvariable id="modifyDeviceOnly" type="java.lang.Boolean"--%>
<%--@elvariable id="taskId" type="java.lang.String"--%>
<%--@elvariable id="createArticle" type="java.lang.Boolean"--%>
<%--@elvariable id="viewArticle" type="java.lang.Boolean"--%>
<%--@elvariable id="articleId" type="java.lang.String"--%>
<%--@elvariable id="dispatcher" type="java.lang.String"--%>
<%--@elvariable id="dispatchers" type="java.util.List"--%>
<%--@elvariable id="dispatcherReadonly" type="java.lang.Boolean"--%>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>${title}</title>
    <%@ include file="/common/allcss.jsp" %>
    <style>
        .help-block { color: #ff0000; }
    </style>
    <c:set var="action" value="#" />
    <c:if test="${createMode == true}">
        <c:set var="action" value="${ctx}/news/topic/start"/>
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
                            <form:form modelAttribute="topic" id="inputForm" action="${action}" class="form form-horizontal"
                                  style="margin-bottom: 0;" method="post" accept-charset="UTF-8">

                                <c:if test="${reapplyMode == true && modifyDeviceOnly != true}">
                                <div class='form-group has-error'>
                                    <label class='col-md-2 control-label' for='leaderbackreason'>审核意见：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='leaderbackreason' name='leaderbackreason' type='text' readonly="readonly">
                                    </div>
                                </div>
                                </c:if>
                                <c:if test="${reapplyMode == true && modifyDeviceOnly == true}">
                                <div class='form-group has-error' id="devicebackblock">
                                    <label class='col-md-2 control-label' for='devicebackreason'>设备部门意见：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='devicebackreason' name='devicebackreason' type='text' readonly="readonly">
                                    </div>
                                </div>
                                </c:if>

                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='topic_title'>标题：</label>
                                    <div class='col-md-10'>
                                        <form:input class='form-control' id='topic_title' path='title' type='text' readonly="${readonly}" />
                                        <form:errors path="title" cssClass="help-block" />
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='topic_reporters'>记者：</label>
                                    <div class='col-md-10'>
                                        <form:select class='select2 form-control' id="topic_reporters" multiple="true" path="reporters">
                                            <form:options items="${reporters}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='topic_cameramen'>摄像员：</label>
                                    <div class='col-md-10'>
                                        <form:select class='select2 form-control' id="topic_cameramen" multiple="true" path="cameramen">
                                            <form:options items="${cameramen}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='topic_dispatcher'>被派遣人：</label>
                                    <div class='col-md-4'>
                                        <form:select class='select2 form-control' id="topic_dispatcher" path="dispatcher">
                                            <form:options items="${dispatchers}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='topic_others'>其他人员：</label>
                                    <div class='col-md-4'>
                                        <form:select class='select2 form-control' id="topic_others" multiple="true" path="others">
                                            <form:options items="${others}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='topic_interviewTime'>采访时间：</label>
                                    <div class='col-md-4'>
                                        <div class='datetimepicker input-group'>
                                            <form:input class='form-control' id='topic_interviewTime' path='interviewTime' type='text' readonly="${readonly}" />
                                            <span class='input-group-addon'>
                                                <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                            </span>
                                        </div>
                                    </div>

                                    <label class='col-md-2 control-label' for='topic_location'>采访地点：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='topic_location' path='location' type='text' readonly="${readonly}" />
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='topic_startTime'>出发时间：</label>
                                    <div class='col-md-4'>
                                        <div class='datetimepicker input-group'>
                                            <form:input class='form-control' id='topic_startTime' path='startTime' type='text' readonly="${readonly}" />
                                            <span class='input-group-addon'>
                                                <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                            </span>
                                        </div>
                                    </div>

                                    <label class='col-md-2 control-label' for='topic_endTime'>返回时间：</label>
                                    <div class='col-md-4'>
                                        <div class='datetimepicker input-group'>
                                            <form:input class='form-control' id='topic_endTime' path='endTime' type='text' readonly="${readonly}" />
                                            <span class='input-group-addon'>
                                                <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='topic_content'>内容：</label>
                                    <div class='col-md-10'>
                                        <%--<form:textarea class='form-control' id='topic_content' path='content' readonly="${readonly}" rows='5' />--%>
                                        <%--<form:errors path="content" cssClass="help-block" />--%>
                                        <form:textarea class='form-control' id='topic_content' path='content' readonly="${readonly}" rows='5' />
                                        <form:errors path="content" cssClass="help-block" />
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='topic_devices'>所需设备/车辆：</label>
                                    <div class='col-md-10'>
                                        <c:set var="devreadonly" value="${readonly}" />
                                        <c:if test="${modifyDeviceOnly == true}">
                                            <c:set var="devreadonly" value="false" />
                                        </c:if>
                                        <form:textarea class='form-control' id='topic_devices' path='devices' readonly="${devreadonly}" rows='3' />
                                    </div>
                                </div>
                                <c:if test="${auditMode == true || auditDeviceMode == true}">
                                    <div class='form-group'>
                                        <label class='col-md-2 control-label' for='opinion'>审核意见：</label>
                                        <div class='col-md-10'>
                                            <input class='form-control' id='opinion' name='opinion' placeholder='审核意见' type='text'>
                                        </div>
                                    </div>
                                    <input type="hidden" name="submit_type" value="" id="submit-type"/>
                                </c:if>
                                <div class='form-actions form-actions-padding-sm'>
                                    <div class='row'>
                                        <div class='col-md-10 col-md-offset-2'>
                                            <c:if test="${createMode == true || reapplyMode == true}">
                                                <button class='btn btn-primary' type='submit'><i class='icon-save'></i>提交</button>
                                            </c:if>
                                            <c:if test="${auditMode == true || auditDeviceMode == true}">
                                                <button class='btn btn-primary' type='submit' id="auditPass"><i class='icon-ok'></i>同意</button>
                                                <button class='btn btn-danger' type='submit' id="auditReject"><i class='icon-remove'></i>驳回</button>
                                            </c:if>
                                            <c:if test="${createArticle == true}">
                                                <button class='btn btn-primary' type='submit'><i class='icon-save'></i>创建文稿</button>
                                            </c:if>
                                            <c:if test="${viewArticle == true}">
                                                <button class='btn btn-primary' type='submit'><i class='icon-save'></i>查看文稿</button>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<%@ include file="/common/alljs.jsp" %>
<script src="${ctx}/assets/javascripts/plugins/ckeditor/ckeditor.js" type="text/javascript"></script>

<script type="text/javascript">

    <c:if test="${auditMode == true || auditDeviceMode == true}">
    $("#auditPass").live("click",function(){
        $("#submit-type").val("pass");
    });

    $("#auditReject").live("click",function(){
        $("#submit-type").val("reject");
    });
    </c:if>

    //  ckeditor采取异步方式setData, 以下函数可以在提交时正确得到ckeditor数据
    function ckupdate() {
        CKEDITOR.instances['topic_content'].updateElement();
    }

    $(function () {
        CKEDITOR.replace('topic_content', {readOnly: (${readonly == true})} );

        //  set readonly states of select2 controls
        <c:if test="${readonly == true}">
        $("#topic_reporters").select2("readonly", true);
        $("#topic_cameramen").select2("readonly", true);
        $("#topic_others").select2("readonly", true);
        </c:if>
        <c:if test="${dispatcherReadonly == true}">
        $("#topic_dispatcher").select2("readonly", true);
        </c:if>

        <c:if test="${reapplyMode == true}">
        $.getJSON(ctx + '/news/topic/detail-with-vars/${topic.id}/${taskId}', function(data) {
            $("#leaderbackreason").val(data.variables.leaderbackreason);
            $("#devicebackreason").val(data.variables.devicebackreason);
            if (data.variables.devicebackreason == undefined)
                $("#devicebackblock").hide();
        });
        </c:if>

        $("#inputForm").submit(function (event) {
            ckupdate();

            var map = {};

            <c:if test="${createArticle == true}">
            location.href = ctx + '/news/article/apply-topic/' + ${topic.id};
            event.preventDefault();
            </c:if>
            <c:if test="${viewArticle == true}">
            location.href = ctx + '/news/article/view/' + ${articleId};
            event.preventDefault();
            </c:if>

            //  audit mode
            <c:if test="${auditMode == true || auditDeviceMode == true}">
            var opinion = $('#opinion').val();
            if (opinion.length == 0) {
                alert('请输入审核意见！');
                event.preventDefault();
                return;
            }
            var passed = false;
            if ($("#submit-type").val() == "pass")
                passed = true;
            <c:if test="${auditMode == true}">
            map["leaderPass"] = passed;
            map["leaderbackreason"] = opinion;
            if (passed == true) {
                map["dispatcher"] = $('#topic_dispatcher').find(':selected').val();
            }
            </c:if>
            <c:if test="${auditDeviceMode == true}">
            map["devicePass"] = passed;
            map["devicebackreason"] = opinion;
            </c:if>
            </c:if>

            //  reapply mode, all changes must send as variable map
            <c:if test="${reapplyMode == true || auditMode == true}">
            map["title"] = $('#topic_title').val();
            map["content"] = $('#topic_content').val();
            map["devices"] = $('#topic_devices').val();
            map["location"] = $('#topic_location').val();
            map["interviewTime"] = $('#topic_interviewTime').val();
            map["startTime"] = $('#topic_startTime').val();
            map["endTime"] = $('#topic_endTime').val();

            var reps = [];
            var cams = [];
            var edts = [];
            var i = 0;
            $.each(
                    $('#topic_reporters' + ' :selected'), function () {
                        reps[i++] = $(this).val();
                    }
            );
            i = 0;
            $.each(
                    $('#topic_cameramen' + ' :selected'), function () {
                        cams[i++] = $(this).val();
                    }
            );
            i = 0;
            $.each(
                    $('#topic_others' + ' :selected'), function () {
                        edts[i++] = $(this).val();
                    }
            );
            map["reporters"] = reps;
            map["cameramen"] = cams;
            map["others"] = edts;
            </c:if>

            <c:if test="${auditMode == true || auditDeviceMode == true || reapplyMode == true}">
            //  sending complete req
            $.ajax({
                type: 'post',
                async: true,
                url: ctx + '/news/topic/complete/' + ${taskId},
                contentType: "application/json; charset=utf-8",
                data : JSON.stringify(map),
                success: function (resp) {
                    if (resp == 'success') {
                        alert('任务完成');
                        location.href = ctx + '/news/topic/list/task'
                    } else {
                        alert('操作失败!');
                    }
                },
                error: function () {
                    alert('操作失败!!');
                }
            });
            event.preventDefault();
            </c:if>
        });
    });

</script>

</body>
</html>