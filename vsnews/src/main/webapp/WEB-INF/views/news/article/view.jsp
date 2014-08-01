<%--
  Created by IntelliJ IDEA.
  User: zhaopeng
  Date: 2014/7/29
  Time: 12:40
  To change this template use File | Settings | File Templates.
--%>
<%--@elvariable id="article" type="com.videostar.vsnews.entity.news.NewsArticle"--%>
<%--@elvariable id="columns" type="java.util.map"--%>
<%--@elvariable id="reporters" type="java.util.List"--%>
<%--@elvariable id="cameramen" type="java.util.List"--%>
<%--@elvariable id="editors" type="java.util.List"--%>
<%--@elvariable id="readonly" type="java.lang.Boolean"--%>
<%--@elvariable id="contentReadonly" type="java.lang.Boolean"--%>
<%--@elvariable id="title" type="java.lang.String"--%>
<%--@elvariable id="createMode" type="java.lang.Boolean"--%>
<%--@elvariable id="auditMode" type="java.lang.Boolean"--%>
<%--@elvariable id="taskId" type="java.lang.String"--%>
<%--@elvariable id="taskKey" type="java.lang.String"--%>
<%--@elvariable id="reapplyMode" type="java.lang.Boolean"--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>${title}</title>
    <%@ include file="/common/allcss.jsp" %>
    <style>
        .help-block {
            color: #ff0000;
        }
    </style>
    <c:if test="${createMode == true}">
        <c:set var="action" value="${ctx}/news/article/start"/>
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
                    <div class='box' style='margin-bottom:0'>
                        <div class='box-header blue-background'>
                            <div class='title'>${title}</div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content'>
                            <form:form modelAttribute="article" id="inputForm" action="${action}" class="form form-horizontal"
                                       style="margin-bottom: 0;" method="post" accept-charset="UTF-8">
                                <c:if test="${reapplyMode == true}">
                                <div class='form-group has-error'>
                                    <label class='col-md-2 control-label' for='auditOpinion'>审核意见：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='auditOpinion' name='auditOpinion' type='text' readonly="readonly">
                                    </div>
                                </div>
                                </c:if>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_mainTitle'>主标题：</label>
                                    <div class='col-md-10'>
                                        <form:input class='form-control' id='article_mainTitle' path='mainTitle' type='text' readonly="${readonly}" />
                                        <form:errors path="mainTitle" cssClass="help-block" />
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_subTitle'>副标题：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='article_subTitle' path='subTitle' type='text' readonly="${readonly}" />
                                    </div>
                                    <label class='col-md-2 control-label' for='article_columnId'>栏目：</label>
                                    <div class='col-md-4'>
                                        <form:select class='select2 form-control' id="article_columnId" path="columnId">
                                            <form:options items="${columns}" itemValue="id" itemLabel="name" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_reporters'>记者：</label>
                                    <div class='col-md-10'>
                                        <form:select class='select2 form-control' id="article_reporters" multiple="true" path="reporters">
                                            <form:options items="${reporters}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_cameramen'>摄像员：</label>
                                    <div class='col-md-10'>
                                        <form:select class='select2 form-control' id="article_cameramen" multiple="true" path="cameramen">
                                            <form:options items="${cameramen}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_editors'>编辑：</label>
                                    <div class='col-md-10'>
                                        <form:select class='select2 form-control' id="article_editors" multiple="true" path="editors">
                                            <form:options items="${editors}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_interviewTime'>采访时间：</label>
                                    <div class='col-md-4'>
                                        <div class='datetimepicker input-group'>
                                            <%--<fmt:formatDate value="${article.interviewTime}"--%>
                                                            <%--type="date"--%>
                                                            <%--pattern="yyyy-MM-dd HH:mm"--%>
                                                            <%--var="f_interviewTime"/>--%>
                                            <form:input class='form-control' id='article_interviewTime' path='interviewTime' type='text' readonly="${readonly}" />
                                            <span class='input-group-addon'>
                                                <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                            </span>
                                        </div>
                                    </div>
                                    <label class='col-md-2 control-label' for='article_location'>采访地点：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='article_location' path='location' type='text' readonly="${readonly}" />
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_sourcers'>报料人：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='article_sourcers' path='sourcers' type='text' readonly="${readonly}" />
                                    </div>

                                    <label class='col-md-2 control-label' for='article_sourcersTel'>报料人电话：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='article_sourcersTel' path='sourcersTel' type='text' readonly="${readonly}" />
                                    </div>
                                </div>

                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_content'>内容：</label>
                                    <div class='col-md-10'>
                                        <form:textarea class='form-control ckeditor' id='article_content' path='content' readonly="${contentReadonly}" rows='7' />
                                        <form:errors path="content" cssClass="help-block" />
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_notes'>备注：</label>
                                    <div class='col-md-10'>
                                        <form:input class='form-control' id='article_notes' path='notes' readonly="${readonly}" type='text' rows="2" />
                                    </div>
                                </div>

                                <%--审核意见--%>
                                <c:if test="${auditMode == true}">
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='opinion'>审核意见：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='opinion' name='opinion' placeholder='审核意见' type='text' rows="2">
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
<script src="${ctx}/assets/javascripts/plugins/ckeditor/ckeditor.js" type="text/javascript"></script>
<script type="text/javascript">
    //  ckeditor采取异步方式setData, 以下函数可以在提交时正确得到ckeditor数据
    function ckupdate() {
        var instance;
        for (instance in CKEDITOR.instances)
            CKEDITOR.instances[instance].updateElement();
    }

    <c:if test="${auditMode eq true}">
    $("#auditPass").live("click",function(){
        $("#submit-type").val("pass");
    });

    $("#auditReject").live("click",function(){
        $("#submit-type").val("reject");
    });
    </c:if>

    $(function () {
        var column_sel = $("#article_columnId");
        column_sel.select2({minimumResultsForSearch: -1});

        //  set readonly states of select2 controls
        <c:if test="${readonly == true}">
            column_sel.select2("readonly", true);
            $("#article_reporters").select2("readonly", true);
            $("#article_cameramen").select2("readonly", true);
            $("#article_editors").select2("readonly", true);
        </c:if>
        //  set readonly states of ckeditor
        <c:if test="${contentReadonly eq true}">
            CKEDITOR.config.readOnly = true;
        </c:if>

        <c:if test="${reapplyMode == true}">
        $.getJSON(ctx + '/news/article/detail-with-vars/${article.id}/${taskId}', function(data) {
            $("#auditOpinion").val(data.variables.auditOpinion);
//            $.each(data, function (k, v) {
//                if (k == "auditOpinion")
//                    $("#auditOpinion").val(v);
//            });
        });
        </c:if>

        $("#inputForm").submit(function (event) {
            ckupdate();
            
            var map = {};

            //  audit mode
            <c:if test="${auditMode == true}">
            var opinion = $('#opinion').val();
            if (opinion.length == 0) {
                alert('请输入审核意见！');
                event.preventDefault();
                return;
            }
            var taskKey = "${taskKey}";
            var passed = false;
            if ($("#submit-type").val() == "pass")
                passed = true;
            switch (taskKey) {
                case 'class1Audit':
                    map["audit1Pass"] = passed;
                    break;
                case 'class2Audit':
                    map["audit2Pass"] = passed;
                    break;
                case 'class3Audit':
                    map["audit3Pass"] = passed;
                    break;
            }
            map["auditOpinion"] = opinion;
            </c:if>
            
            //  reapply mode, all changes must send as variable map
            <c:if test="${reapplyMode == true}">
            map["mainTitle"] = $('#article_mainTitle').val();
            map["subTitle"] = $('#article_subTitle').val();
            map["content"] = $('#article_content').val();
            map["location"] = $('#article_location').val();
            map["interviewTime"] = $('#article_interviewTime').val();
            map["sourcers"] = $('#article_sourcers').val();
            map["sourcersTel"] = $('#article_sourcersTel').val();
            map["notes"] = $('#article_notes').val();

            //  new Array()不能用{}代替，否则会报错！
            var reps = [];//new Array();
            var cams = [];//new Array();
            var edts = [];//new Array();
            var i = 0;
            $.each(
                    $('#article_reporters' + ' :selected'), function () {
                        reps[i++] = $(this).val();
                    }
            );
            i = 0;
            $.each(
                    $('#article_cameramen' + ' :selected'), function () {
                        cams[i++] = $(this).val();
                    }
            );
            i = 0;
            $.each(
                    $('#article_editors' + ' :selected'), function () {
                        edts[i++] = $(this).val();
                    }
            );
            map["reporters"] = reps;
            map["cameramen"] = cams;
            map["editors"] = edts;
            </c:if>

            <c:if test="${auditMode == true || reapplyMode == true}">
            //  sending complete req
            $.ajax({
                type: 'post',
                async: true,
                url: ctx + '/news/article/complete/' + ${taskId},
                contentType: "application/json; charset=utf-8",
                data : JSON.stringify(map),
                success: function (resp) {
                    if (resp == 'success') {
                        alert('任务完成');
                        location.href = ctx + '/news/article/list/task'
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
