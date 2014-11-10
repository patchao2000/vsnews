<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14/11/7
  Time: 下午6:39
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--@elvariable id="storyboardTemplate" type="com.videostar.vsnews.entity.news.NewsStoryboardTemplate"--%>
<%--@elvariable id="title" type="java.lang.String"--%>
<%--@elvariable id="readonly" type="java.lang.Boolean"--%>
<%--@elvariable id="createMode" type="java.lang.Boolean"--%>
<%--@elvariable id="reapplyMode" type="java.lang.Boolean"--%>
<%--@elvariable id="editors" type="java.util.List"--%>
<%--@elvariable id="technicians" type="java.util.List"--%>
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
        <c:set var="action" value="${ctx}/news/storyboard/start-template"/>
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
                            <form:form modelAttribute="storyboardTemplate" id="inputForm" action="${action}" class="form form-horizontal"
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
                                    <label class='col-md-2 control-label' for='storyboard_studio'>演播室：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='storyboard_studio' path='studio' type='text' readonly="${readonly}" />
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
                                <hr class='hr-normal'>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_eic'>责编：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_eic" multiple="true" path="editorsInCharge">
                                            <form:options items="${editors}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_instructors'>导播：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_instructors" multiple="true" path="instructors">
                                            <form:options items="${editors}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_editors'>记者：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_editors" multiple="true" path="editors">
                                            <form:options items="${editors}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_producers'>监制：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_producers" multiple="true" path="producers">
                                            <form:options items="${editors}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_directors'>主任：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_directors" multiple="true" path="directors">
                                            <form:options items="${editors}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_announcers'>播音员：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_announcers" multiple="true" path="announcers">
                                            <form:options items="${technicians}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_voiceActors'>配音员：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_voiceActors" multiple="true" path="voiceActors">
                                            <form:options items="${technicians}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_subtitlers'>字幕员：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_subtitlers" multiple="true" path="subtitlers">
                                            <form:options items="${technicians}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_cameramen'>摄影师：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_cameramen" multiple="true" path="cameramen">
                                            <form:options items="${technicians}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_lightingEngineers'>灯光：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_lightingEngineers" multiple="true" path="lightingEngineers">
                                            <form:options items="${technicians}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_technicians'>技术：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_technicians" multiple="true" path="technicians">
                                            <form:options items="${technicians}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <hr class='hr-normal'>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_notes'>备注：</label>
                                    <div class='col-md-10'>
                                        <form:textarea class='form-control' id='storyboard_notes' path='notes' readonly="${readonly}" rows='3' />
                                    </div>
                                </div>
                                <c:if test="${auditMode == true}">
                                    <div class='form-group'>
                                        <label class='col-md-2 control-label' for='storyboard_auditOpinion'>审核意见：</label>
                                        <div class='col-md-10'>
                                            <form:textarea class='form-control' id='storyboard_auditOpinion' path='auditOpinion' />
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

    function setMultiSelectToMap(id, map_index, map) {
        var array = [];
        var i = 0;
        $.each(
                $(id + ' :selected'), function () {
                    array[i++] = $(this).val();
                }
        );
        map[map_index] = array;
    }

    $(function () {
        <c:if test="${readonly == true}">
        $("#storyboard_columnId").select2("readonly", true);
        $("#storyboard_editors").select2("readonly", true);
        $("#storyboard_eic").select2("readonly", true);
        $("#storyboard_instructors").select2("readonly", true);
        $("#storyboard_producers").select2("readonly", true);
        $("#storyboard_directors").select2("readonly", true);
        $("#storyboard_announcers").select2("readonly", true);
        $("#storyboard_voiceActors").select2("readonly", true);
        $("#storyboard_subtitlers").select2("readonly", true);
        $("#storyboard_cameramen").select2("readonly", true);
        $("#storyboard_lightingEngineers").select2("readonly", true);
        $("#storyboard_technicians").select2("readonly", true);
        </c:if>

        <c:if test="${reapplyMode == true}">
            $.getJSON(ctx + '/news/storyboard/detail-with-vars/template/${storyboardTemplate.id}/${taskId}', function(data) {
                $("#leaderbackreason").val(data.variables.leaderbackreason);
                if (data.variables.devicebackreason == undefined)
                    $("#devicebackblock").hide();
            });
        </c:if>

        $("#inputForm").submit(function (event) {
            var map = {};

            //  audit mode
            <c:if test="${auditMode == true}">
                var opinion = $('#storyboard_auditOpinion').val();
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
            <c:if test="${reapplyMode == true}">
                map["title"] = $('#storyboard_title').val();
                map["startTC"] = $('#storyboard_startTC').val();
                map["endTC"] = $('#storyboard_endTC').val();
                map["columnId"] = $('#storyboard_columnId' + ' :selected').val();
                map["notes"] = $('#storyboard_notes').val();
                map["studio"] = $('#storyboard_studio').val();

                setMultiSelectToMap('#storyboard_editors', 'editors', map);
                setMultiSelectToMap('#storyboard_eic', 'editorsInCharge', map);
                setMultiSelectToMap('#storyboard_instructors', 'instructors', map);
                setMultiSelectToMap('#storyboard_producers', 'producers', map);
                setMultiSelectToMap('#storyboard_directors', 'directors', map);
                setMultiSelectToMap('#storyboard_announcers', 'announcers', map);
                setMultiSelectToMap('#storyboard_voiceActors', 'voiceActors', map);
                setMultiSelectToMap('#storyboard_subtitlers', 'subtitlers', map);
                setMultiSelectToMap('#storyboard_cameramen', 'cameramen', map);
                setMultiSelectToMap('#storyboard_lightingEngineers', 'lightingEngineers', map);
                setMultiSelectToMap('#storyboard_technicians', 'technicians', map);
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