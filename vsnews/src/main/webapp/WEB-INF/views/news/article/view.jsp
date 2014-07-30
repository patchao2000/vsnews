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
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>查看文稿内容</title>
    <%@ include file="/common/allcss.jsp" %>
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
                            <div class='title'>查看文稿内容</div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content'>
                            <form:form modelAttribute="article" id="inputForm" action="#" class="form form-horizontal" style="margin-bottom: 0;" method="post" accept-charset="UTF-8">
                                <%--<input name="authenticity_token" type="hidden"/>--%>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_mainTitle'>主标题：</label>
                                    <div class='col-md-10'>
                                        <form:input class='form-control' id='article_mainTitle' path='mainTitle' type='text' readonly="true" />
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_subTitle'>副标题：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='article_subTitle' path='subTitle' type='text' readonly="true" />
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
                                            <form:input class='form-control' id='article_interviewTime' path='interviewTime' type='text' readonly="true" />
                                            <span class='input-group-addon'>
                                                <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                            </span>
                                        </div>
                                    </div>
                                    <label class='col-md-2 control-label' for='article_location'>采访地点：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='article_location' path='location' type='text' readonly="true" />
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_sourcers'>报料人：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='article_sourcers' path='sourcers' type='text' readonly="true" />
                                    </div>

                                    <label class='col-md-2 control-label' for='article_sourcersTel'>报料人电话：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='article_sourcersTel' path='sourcersTel' type='text' readonly="true" />
                                    </div>
                                </div>

                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_content'>内容：</label>
                                    <div class='col-md-10'>
                                        <form:textarea class='form-control ckeditor' id='article_content' path='content' readonly="true" rows='7' />
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='article_notes'>备注：</label>
                                    <div class='col-md-10'>
                                        <form:input class='form-control' id='article_notes' path='notes' readonly="true" type='text' rows="2" />
                                    </div>
                                </div>
                                <%--<div class='form-actions form-actions-padding-sm'>--%>
                                    <%--<div class='row'>--%>
                                        <%--<div class='col-md-10 col-md-offset-2'>--%>
                                            <%--<button class='btn btn-primary' type='submit'><i class='icon-save'></i>提交</button>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
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
//    function fillUserColumnsControl(userId) {
//        $.getJSON(ctx + '/news/column/objlist/usercolumns/' + userId, function (data) {
//            var columns = '';
//            var template = "<option value='#id'>#name</option>";
//            $.each(data, function (dk, dv) {
//                var curr = template;
//                $.each(dv, function (k, v) {
//                    if (k == 'id') {
//                        curr = curr.replace(/#id/g, v);
//                    }
//                    else if (k == 'name') {
//                        curr = curr.replace(/#name/g, v);
//                    }
//                });
//                columns += curr;
//            });
//            $('#column_sel').html(columns);
//        });
//    }

//    function fillSelectControlWithGroup(controlId, groupId) {
//        $.getJSON(ctx + '/user/objlist/groupmembers/' + groupId, function (data) {
//            var users = '';
//            var template = "<option value='#id'>#name</option>";
//            $.each(data, function (dk, dv) {
//                var curr = template;
//                $.each(dv, function (k, v) {
//                    if (k == 'userId') {
//                        curr = curr.replace(/#id/g, v);
//                    }
//                    else if (k == 'firstName') {
//                        curr = curr.replace(/#name/g, v);
//                    }
//                });
//                users += curr;
//            });
//            $('#' + controlId).html(users);
//        });
//    }

//    function makeMultiSelectValues(controlId, fieldName) {
//        var index = 0;
//        $.each(
//                $('#' + controlId + ' :selected'), function () {
//                    var input = $('<input>');
//                    input.attr("name", fieldName + "[" + index + "]");
//                    input.attr("type", "hidden");
//                    input.attr("value", $(this).val());
//                    $('#' + controlId).append(input);
//                    index++;
//                }
//        );
//    }
//
//    function loadDetailWithTaskVars(articleId) {
//        $.getJSON(ctx + '/news/article/detail/' + articleId, function (data) {
//            $.each(data, function (k, v) {
//                if (k == "reporters")
//                    $('#reporters_sel').select2().select2('val', v);
//                else if (k == "cameramen")
//                    $('#cameramen_sel').select2().select2('val', v);
//                else if (k == "editors")
//                    $('#editors_sel').select2().select2('val', v);
//                else if (k == "column")
//                    $('#column_sel').select2().select2('val', v);
//            });
//        });
//    }

    $(function () {
        <%--CKEDITOR.config.readOnly = true;--%>

        <%--$.ajaxSettings.async = false;--%>

        <%--fillSelectControlWithGroup('reporters_sel', 'reporter');--%>
        <%--fillSelectControlWithGroup('cameramen_sel', 'cameraman');--%>
        <%--fillSelectControlWithGroup('editors_sel', 'editor');--%>
        <%--$("#reporters_sel").select2("readonly", true);--%>
        <%--$("#cameramen_sel").select2("readonly", true);--%>
        <%--$("#editors_sel").select2("readonly", true);--%>

        <%--fillUserColumnsControl('${user.id }');--%>
        var column_sel = $("#article_columnId");
        column_sel.select2({minimumResultsForSearch: -1});

        <%--loadDetailWithTaskVars(${article.id});--%>
        <%--column_sel.select2("readonly", true);--%>

        <%--$.ajaxSettings.async = true;--%>
    });
</script>

</body>
</html>
