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
        String paraReApply = request.getParameter("reapply");
        String paraAudit = request.getParameter("audit");
        String ctx = request.getContextPath();
        String action = ctx + "/news/article/start";
        String htmlTitle = "编辑文稿";

        boolean reApplyMode = false, auditMode = false;
        if (paraReApply != null && paraReApply.equals("true")) {
            htmlTitle = "调整文稿内容";
            reApplyMode = true;
            action = "#";
        } else if (paraAudit != null && paraAudit.equals("true")) {
            htmlTitle = "审核文稿";
            auditMode = true;
            action = "#";
        }
    %>
    <title><%=htmlTitle%></title>
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
                            <div class='title'><%=htmlTitle%></div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content'>
                            <form id="inputForm" action="<%=action%>" class="form form-horizontal" style="margin-bottom: 0;" method="post" accept-charset="UTF-8">
                                <input name="authenticity_token" type="hidden"/>
                                <% if (reApplyMode) { %>
                                <div class='form-group has-error'>
                                    <label class='col-md-2 control-label' for='auditOpinion'>审核意见：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='auditOpinion' name='auditOpinion' type='text' readonly="readonly">
                                    </div>
                                </div>
                                <% } %>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='mainTitle'>主标题：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='mainTitle' name='mainTitle' placeholder='主标题' type='text'>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='subTitle'>副标题：</label>
                                    <div class='col-md-4'>
                                        <input class='form-control' id='subTitle' name='subTitle' placeholder='副标题' type='text'>
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
                                    <label class='col-md-2 control-label' for='content1'>内容：</label>
                                    <div class='col-md-10'>
                                        <textarea class='form-control ckeditor' id='content1' name = 'content' placeholder='内容' rows='7'></textarea>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='notes'>备注：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='notes' name='notes' placeholder='备注' type='text' rows="2">
                                    </div>
                                </div>
                                <% if (auditMode) { %>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='opinion'>审核意见：</label>
                                    <div class='col-md-10'>
                                        <input class='form-control' id='opinion' name='opinion' placeholder='审核意见' type='text' rows="2">
                                    </div>
                                </div>
                                <input type="hidden" name="submit_type" value="" id="submit-type"/>
                                <% } %>
                                <div class='form-actions form-actions-padding-sm'>
                                    <div class='row'>
                                        <div class='col-md-10 col-md-offset-2'>
                                            <% if (auditMode) { %>
                                            <button class='btn btn-primary' type='submit' id="auditPass"><i class='icon-ok'></i>同意</button>
                                            <button class='btn btn-danger' type='submit' id="auditReject"><i class='icon-remove'></i>驳回</button>
                                            <% } else { %>
                                            <button class='btn btn-primary' type='submit'><i class='icon-save'></i>提交</button>
                                            <% } %>
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
    function complete(taskid, varmap) {
        // 发送任务完成请求
        $.ajax({
            type: 'post',
            async: false,
            url: ctx + '/news/article/complete/' + taskid,
            contentType: "application/json; charset=utf-8",
            data : JSON.stringify(varmap),
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
    }

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

    <% if (reApplyMode || auditMode) { %>
    var articleid = '<%=request.getParameter("id") %>';
    var taskid = '<%=request.getParameter("taskid") %>';
    function loadDetailWithTaskVars(articleId, taskId, callback) {
        $.getJSON(ctx + '/news/article/detail-with-vars/' + articleId + "/" + taskId, function (data) {
            $.each(data, function (k, v) {
                if (k == "content")
                    $("#content1").val(v);
                else if (k == "reporters")
                    $('#reporters_sel').select2().select2('val', v);
                else if (k == "cameramen")
                    $('#cameramen_sel').select2().select2('val', v);
                else if (k == "editors")
                    $('#editors_sel').select2().select2('val', v);
                else if (k == "column")
                    $('#column_sel').select2().select2('val', v);
                else if (k == "interviewTime") {
                    if (v != null) {
                        var d = new Date(v).format("yyyy-MM-dd hh:mm");
                        $("#" + k).val(d);
                    }
                }
                else
                    $("#" + k).val(v);
            });
            if ($.isFunction(callback)) {
                callback(data);
            }
        });
    }
    <% } %>

    //  ckeditor采取异步方式setData, 以下函数可以在提交时正确得到ckeditor数据
    function ckupdate() {
        var instance;
        for (instance in CKEDITOR.instances)
            CKEDITOR.instances[instance].updateElement();
    }

    $("#auditPass").live("click",function(){
        $("#submit-type").val("pass");
    });

    $("#auditReject").live("click",function(){
        $("#submit-type").val("reject");
    })

    $(function () {
        $.ajaxSettings.async = false;

        fillSelectControlWithGroup('reporters_sel', 'reporter');
        fillSelectControlWithGroup('cameramen_sel', 'cameraman');
        fillSelectControlWithGroup('editors_sel', 'editor');

        fillUserColumnsControl('${user.id }');
        var column_sel = $("#column_sel");
        column_sel.select2({minimumResultsForSearch: -1});

        <% if (reApplyMode || auditMode) { %>
        loadDetailWithTaskVars(articleid, taskid, function (data) {
            $("#auditOpinion").val(data.variables.auditOpinion);
        });
        column_sel.select2("readonly", true);
        <% } %>


        $.ajaxSettings.async = true;

        $("#inputForm").submit(function (event) {
            ckupdate();

            var mainTitle = $('#mainTitle');
            var content1 = $('#content1');

            if (mainTitle.val().length == 0) {
                alert('标题不能为空！');
                event.preventDefault();
                return;
            }
            if (content1.val().length == 0) {
                alert('内容不能为空！');
                event.preventDefault();
                return;
            }

            makeMultiSelectValues('reporters_sel', 'reporters');
            makeMultiSelectValues('cameramen_sel', 'cameramen');
            makeMultiSelectValues('editors_sel', 'editor');

            $('#columnId').val($('#column_sel').find(':selected').val());

            <% if (reApplyMode || auditMode) { %>

            var articlemap = {};
            articlemap["mainTitle"] = mainTitle.val();
            articlemap["subTitle"] = $('#subTitle').val();
            articlemap["content"] = content1.val();
            articlemap["location"] = $('#location').val();
            articlemap["interviewTime"] = $('#interviewTime').val();
            articlemap["sourcers"] = $('#sourcers').val();
            articlemap["sourcersTel"] = $('#sourcersTel').val();
            articlemap["notes"] = $('#notes').val();

            //  new Array()不能用{}代替，否则会报错！
            var reps = new Array();
            var cams = new Array();
            var edts = new Array();
            var i = 0;
            $.each(
                    $('#reporters_sel' + ' :selected'), function () {
                        reps[i++] = $(this).val();
                    }
            );
            i = 0;
            $.each(
                    $('#cameramen_sel' + ' :selected'), function () {
                        cams[i++] = $(this).val();
                    }
            );
            i = 0;
            $.each(
                    $('#editors_sel' + ' :selected'), function () {
                        edts[i++] = $(this).val();
                    }
            );
            articlemap["reporters"] = reps;
            articlemap["cameramen"] = cams;
            articlemap["editors"] = edts;

//            todo: check $("#submit-type").val() for set auditPass variable
            $.ajax({
                type: 'post',
                async: false,
                url: ctx + '/news/article/complete/' + taskid,
                contentType: "application/json; charset=utf-8",
                data : JSON.stringify(articlemap),
                success: function (resp) {
                    if (resp == 'success') {
                        alert('任务完成');
                        location.href = ctx + '/news/article/list/task'
                    } else {
                        alert('操作失败!');
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert('操作失败!!');
                }
            });

            event.preventDefault();
            <% } %>
        });
    });
</script>

</body>
</html>
