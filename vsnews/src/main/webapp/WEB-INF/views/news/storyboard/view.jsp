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
<%--@elvariable id="editors" type="java.util.List"--%>
<%--@elvariable id="columns" type="java.util.map"--%>
<%--@elvariable id="auditMode" type="java.lang.Boolean"--%>
<%--@elvariable id="taskId" type="java.lang.String"--%>
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
        <c:set var="action" value="${ctx}/news/storyboard/start"/>
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
                                    <label class='col-md-2 control-label' for='storyboard_title'>标题：</label>
                                    <div class='col-md-10'>
                                        <form:input class='form-control' id='storyboard_title' path='title' type='text' readonly="${readonly}" />
                                        <form:errors path="title" cssClass="help-block" />
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_columnId'>栏目：</label>
                                    <div class='col-md-4'>
                                        <form:select class='select2 form-control' id="storyboard_columnId" path="columnId">
                                            <form:options items="${columns}" itemValue="id" itemLabel="name" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_editors'>记者：</label>
                                    <div class='col-md-4'>
                                        <form:select class='select2 form-control' id="storyboard_editors" multiple="true" path="editors">
                                            <form:options items="${editors}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_airDate'>播出时间：</label>
                                    <div class='col-md-10'>
                                        <div class='datetimepicker input-group'>
                                            <form:input class='form-control' id='storyboard_airDate' path='airDate' type='text' readonly="${readonly}" />
                                            <span class='input-group-addon'>
                                                <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_startTC'>开始时段：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='storyboard_startTC' path='startTC' type='text' readonly="${readonly}" />
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_endTC'>结束时段：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='storyboard_endTC' path='endTC' type='text' readonly="${readonly}" />
                                    </div>
                                </div>
                                <c:if test="${auditMode == true}">
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
        </div>
    </section>
</div>
<%@ include file="/common/alljs.jsp" %>

<script type="text/javascript">
    <c:if test="${auditMode == true}">
    $("#auditPass").live("click",function(){
        $("#submit-type").val("pass");
    });

    $("#auditReject").live("click",function(){
        $("#submit-type").val("reject");
    });
    </c:if>

    $(function () {
        <c:if test="${readonly == true}">
        $("#storyboard_columnId").select2("readonly", true);
        $("#article_editors").select2("readonly", true);
        </c:if>

        <c:if test="${reapplyMode == true}">
        $.getJSON(ctx + '/news/storyboard/detail-with-vars/${storyboard.id}/${taskId}', function(data) {
            $("#leaderbackreason").val(data.variables.leaderbackreason);
            if (data.variables.devicebackreason == undefined)
                $("#devicebackblock").hide();
        });
        </c:if>

        $("#inputForm").submit(function (event) {
            var map = {};

            //  audit mode
            <c:if test="${auditMode == true}">
            var opinion = $('#opinion').val();
            if (opinion.length == 0) {
                alert('请输入审核意见！');
                event.preventDefault();
                return;
            }
            var passed = false;
            if ($("#submit-type").val() == "pass")
                passed = true;
            map["leaderPass"] = passed;
            map["leaderbackreason"] = opinion;
            </c:if>

            //  reapply mode, all changes must send as variable map
            <c:if test="${reapplyMode == true || auditMode == true}">
            map["title"] = $('#storyboard_title').val();
            map["airDate"] = $('#storyboard_airDate').val();
            map["startTC"] = $('#storyboard_startTC').val();
            map["endTC"] = $('#storyboard_endTC').val();
            map["columnId"] = $('#storyboard_columnId' + ' :selected').val();

            var edts = [];
            var i = 0;
            $.each(
                    $('#storyboard_editors' + ' :selected'), function () {
                        edts[i++] = $(this).val();
                    }
            );
            map["editors"] = edts;
            </c:if>

            <c:if test="${auditMode == true || reapplyMode == true}">
            //  sending complete req
            $.ajax({
                type: 'post',
                async: true,
                url: ctx + '/news/storyboard/complete/' + ${taskId},
                contentType: "application/json; charset=utf-8",
                data : JSON.stringify(map),
                success: function (resp) {
                    if (resp == 'success') {
                        alert('任务完成');
                        location.href = ctx + '/news/storyboard/list/task'
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