<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-6-27
  Time: 下午4:28
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
        String mainTitle = "编辑文稿";
    %>
    <title><%=mainTitle%></title>
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
                            <div class='title'><%=mainTitle%></div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content'>
                            <form id="inputForm" action="#" class="form form-horizontal" style="margin-bottom: 0;" method="post" accept-charset="UTF-8">
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='mainTitle'>主标题：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='mainTitle' name='mainTitle' placeholder='主标题' type='text'>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='subTitle'>副标题：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='subTitle' name='subTitle' placeholder='副标题' type='text'>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='reporters'>记者：</label>

                                    <div class='col-md-10'>
                                        <select class='select2 form-control' multiple placeholder='点击选择记者' id="reporters_sel"></select>
                                        <input type='hidden' id='reporters' name='reporters' value=''>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='cameramen'>摄像员：</label>

                                    <div class='col-md-10'>
                                        <select class='select2 form-control' multiple placeholder='点击选择摄像员' id="cameramen_sel"></select>
                                        <input type='hidden' id='cameramen' name='cameramen' value=''>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='editors'>编辑：</label>

                                    <div class='col-md-10'>
                                        <select class='select2 form-control' multiple placeholder='点击选择编辑' id="editors_sel"></select>
                                        <input type='hidden' id='editors' name='editors' value=''>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='interviewTime'>采访时间：</label>
                                    <div class='col-md-4'>
                                        <div class='datetimepicker input-group'>
                                            <input class='form-control' id='interviewTime' name='interviewTime' placeholder='请选择时间' type='text'>
                                            <span class='input-group-addon'>
                                                <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                            </span>
                                        </div>
                                    </div>
                                    <label class='col-md-2 control-label' for='location'>采访地点：</label>
                                    <div class='col-md-4'>
                                        <input class='form-control' id='location' name='location' type='text'>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='sourcers'>报料人：</label>
                                    <div class='col-md-4'>
                                        <input class='form-control' id='sourcers' name='sourcers' type='text'>
                                    </div>

                                    <label class='col-md-2 control-label' for='sourcersTel'>报料人电话：</label>
                                    <div class='col-md-4'>
                                        <input class='form-control' id='sourcersTel' name='sourcersTel' type='text'>
                                    </div>
                                </div>

                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='text'>内容：</label>
                                    <div class='col-md-10'>
                                        <textarea class='form-control ckeditor' id='text' name = 'text' placeholder='内容' rows='7'></textarea>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='notes'>备注：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='notes' name='notes' placeholder='备注' type='text' rows="2">
                                    </div>
                                </div>
                                <div class='form-actions form-actions-padding-sm'>
                                    <div class='row'>
                                        <div class='col-md-10 col-md-offset-2'>
                                            <button class='btn btn-primary' type='submit'><i class='icon-save'></i>提交</button>
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

    $(function () {
        $.ajaxSettings.async = false;

        fillSelectControlWithGroup('reporters_sel', 'reporter');
        fillSelectControlWithGroup('cameramen_sel', 'cameraman');
//        fillSelectControlWithGroup('others_sel', 'stuff');

        $.ajaxSettings.async = true;
    });
</script>

</body>
</html>
