<%--
  Created by IntelliJ IDEA.
  User: zhaopeng
  Date: 2014/7/29
  Time: 12:40
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--@elvariable id="article" type="com.videostar.vsnews.entity.news.NewsArticle"--%>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <%
        String ctx = request.getContextPath();
    %>
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
                            <form id="inputForm" action="#" class="form form-horizontal" style="margin-bottom: 0;" method="post" accept-charset="UTF-8">
                                <input name="authenticity_token" type="hidden"/>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='mainTitle'>主标题：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='mainTitle' name='mainTitle' placeholder='主标题'
                                               type='text' readonly="readonly" value="${article.mainTitle}">
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='subTitle'>副标题：</label>
                                    <div class='col-md-4'>
                                        <input class='form-control' id='subTitle' name='subTitle' placeholder='副标题'
                                               type='text' readonly="readonly" value="${article.subTitle}">
                                    </div>
                                    <label class='col-md-2 control-label' for='columnId'>栏目：</label>
                                    <div class='col-md-4'>
                                        <select class='form-control' id="column_sel"></select>
                                        <input type='hidden' id='columnId' name='columnId' value=''>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='reporters'>记者：</label>

                                    <div class='col-md-10'>
                                        <select class='select2 form-control' multiple id="reporters_sel"></select>
                                        <input type='hidden' id='reporters' name='reporters' value=''>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='cameramen'>摄像员：</label>

                                    <div class='col-md-10'>
                                        <select class='select2 form-control' multiple id="cameramen_sel"></select>
                                        <input type='hidden' id='cameramen' name='cameramen' value=''>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='editors'>编辑：</label>

                                    <div class='col-md-10'>
                                        <select class='select2 form-control' multiple id="editors_sel"></select>
                                        <input type='hidden' id='editors' name='editors' value=''>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='interviewTime'>采访时间：</label>
                                    <div class='col-md-4'>
                                        <div class='datetimepicker input-group'>
                                            <fmt:formatDate value="${article.interviewTime}"
                                                            type="date"
                                                            pattern="yyyy-MM-dd HH:mm"
                                                            var="f_interviewTime"/>
                                            <input class='form-control' id='interviewTime' name='interviewTime' type='text'
                                                   value="${f_interviewTime}" readonly="readonly">
                                            <span class='input-group-addon'>
                                                <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                            </span>
                                        </div>
                                    </div>
                                    <label class='col-md-2 control-label' for='location'>采访地点：</label>
                                    <div class='col-md-4'>
                                        <input class='form-control' id='location' name='location' type='text'
                                               readonly="readonly" value="${article.location}">
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='sourcers'>报料人：</label>
                                    <div class='col-md-4'>
                                        <input class='form-control' id='sourcers' name='sourcers' type='text'
                                               readonly="readonly" value="${article.sourcers}">
                                    </div>

                                    <label class='col-md-2 control-label' for='sourcersTel'>报料人电话：</label>
                                    <div class='col-md-4'>
                                        <input class='form-control' id='sourcersTel' name='sourcersTel' type='text'
                                               readonly="readonly" value="${article.sourcersTel}">
                                    </div>
                                </div>

                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='content1'>内容：</label>
                                    <div class='col-md-10'>
                                        <textarea class='form-control ckeditor' id='content1' name = 'content' readonly="readonly" rows='7'>
                                            ${article.content}
                                        </textarea>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='notes'>备注：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='notes' name='notes' placeholder='备注'
                                               readonly="readonly" value="${article.notes}" type='text' rows="2">
                                    </div>
                                </div>
                                <%--<div class='form-actions form-actions-padding-sm'>--%>
                                    <%--<div class='row'>--%>
                                        <%--<div class='col-md-10 col-md-offset-2'>--%>
                                            <%--<button class='btn btn-primary' type='submit'><i class='icon-save'></i>提交</button>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
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
<script type="text/javascript">
    function fillUserColumnsControl(userId) {
        $.getJSON(ctx + '/news/column/objlist/usercolumns/' + userId, function (data) {
            var columns = '';
            var template = "<option value='#id'>#name</option>";
            $.each(data, function (dk, dv) {
                var curr = template;
                $.each(dv, function (k, v) {
                    if (k == 'id') {
                        curr = curr.replace(/#id/g, v);
                    }
                    else if (k == 'name') {
                        curr = curr.replace(/#name/g, v);
                    }
                });
                columns += curr;
            });
            $('#column_sel').html(columns);
        });
    }

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

    function loadDetailWithTaskVars(articleId) {
        $.getJSON(ctx + '/news/article/detail/' + articleId, function (data) {
            $.each(data, function (k, v) {
                if (k == "reporters")
                    $('#reporters_sel').select2().select2('val', v);
                else if (k == "cameramen")
                    $('#cameramen_sel').select2().select2('val', v);
                else if (k == "editors")
                    $('#editors_sel').select2().select2('val', v);
                else if (k == "column")
                    $('#column_sel').select2().select2('val', v);
            });
        });
    }

    $(function () {
        CKEDITOR.config.readOnly = true;

        $.ajaxSettings.async = false;

        fillSelectControlWithGroup('reporters_sel', 'reporter');
        fillSelectControlWithGroup('cameramen_sel', 'cameraman');
        fillSelectControlWithGroup('editors_sel', 'editor');
        $("#reporters_sel").select2("readonly", true);
        $("#cameramen_sel").select2("readonly", true);
        $("#editors_sel").select2("readonly", true);

        fillUserColumnsControl('${user.id }');
        var column_sel = $("#column_sel");
        column_sel.select2({minimumResultsForSearch: -1});

        loadDetailWithTaskVars(${article.id});
        column_sel.select2("readonly", true);

        $.ajaxSettings.async = true;
    });
</script>

</body>
</html>
