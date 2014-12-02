<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- / jquery [required] -->
<script src="${ctx}/assets/javascripts/jquery/jquery.min.js" type="text/javascript"></script>
<!-- / jquery mobile (for touch events) -->
<script src="${ctx}/assets/javascripts/jquery/jquery.mobile.custom.min.js" type="text/javascript"></script>
<!-- / jquery migrate (for compatibility with new jquery) [required] -->
<script src="${ctx}/assets/javascripts/jquery/jquery-migrate.min.js" type="text/javascript"></script>
<!-- / jquery ui -->
<script src="${ctx}/assets/javascripts/jquery/jquery-ui.min.js" type="text/javascript"></script>
<!-- / jQuery UI Touch Punch -->
<script src="${ctx}/assets/javascripts/plugins/jquery_ui_touch_punch/jquery.ui.touch-punch.min.js"
        type="text/javascript"></script>
<!-- / bootstrap [required] -->
<%--<script src="${ctx}/assets/javascripts/bootstrap/bootstrap.js" type="text/javascript"></script>--%>
<script src="${ctx}/js/common/bootstrap/js/bootstrap.js" type="text/javascript"></script>
<!-- / modernizr -->
<script src="${ctx}/assets/javascripts/plugins/modernizr/modernizr.min.js" type="text/javascript"></script>
<!-- / retina -->
<script src="${ctx}/assets/javascripts/plugins/retina/retina.js" type="text/javascript"></script>
<!-- / theme file [required] -->
<script src="${ctx}/assets/javascripts/theme.js" type="text/javascript"></script>
<!-- / demo file [not required!] -->
<script src="${ctx}/assets/javascripts/demo.js" type="text/javascript"></script>
<!-- / START - page related files and scripts [optional] -->

<script src="${ctx}/assets/javascripts/plugins/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="${ctx}/assets/javascripts/plugins/datatables/jquery.dataTables.columnFilter.js" type="text/javascript"></script>
<script src="${ctx}/assets/javascripts/plugins/datatables/dataTables.overrides.js" type="text/javascript"></script>

<%--<script src="${ctx}/js/common/plugins/datatables/js/jquery.dataTables.min.js" type="text/javascript"></script>--%>
<%--<script src="${ctx}/js/common/plugins/datatables/js/dataTables.bootstrap.js" type="text/javascript"></script>--%>

<%--<script src="${ctx}/assets/javascripts/plugins/flot/excanvas.js" type="text/javascript"></script>--%>
<%--<script src="${ctx}/assets/javascripts/plugins/flot/flot.min.js" type="text/javascript"></script>--%>
<%--<script src="${ctx}/assets/javascripts/plugins/flot/flot.resize.js" type="text/javascript"></script>--%>
<!-- / END - page related files and scripts [optional] -->
<script src="${ctx}/assets/javascripts/plugins/bootstrap_datetimepicker/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/assets/javascripts/plugins/select2/select2.js" type="text/javascript"></script>
<script src="${ctx}/js/common/plugins/jquery.maskedinput.min.js" type="text/javascript"></script>
<script>
    $('.datetimepicker').datetimepicker({
        format: 'yyyy-MM-dd hh:mm',
        language: 'ch',
        pickDate: true,
        pickTime: true,
        hourStep: 1,
        minuteStep: 15,
        secondStep: 30,
        inputMask: true
    });

    $('.datepicker').datetimepicker({
        format: 'yyyy-MM-dd',
        language: 'ch',
        pickDate: true,
        pickTime: false,
        inputMask: true
    });

    Date.prototype.format = function(format) {
        var o = {
            "M+": this.getMonth() + 1, //month
            "d+": this.getDate(), //day
            "h+": this.getHours(), //hour
            "m+": this.getMinutes(), //minute
            "s+": this.getSeconds(), //second
            "q+": Math.floor((this.getMonth() + 3) / 3), //quarter
            "S": this.getMilliseconds() //millisecond
        };
        if (/(y+)/.test(format))
            format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(format))
                format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        return format;
    }

    $("#loginOut").live("click", function () {
        if (confirm('系统提示，您确定要退出本次登录吗?')) {
            location.href = ctx + '/user/logout';
        }
    });

    $('#save-password').click(function () {
        var oldpassword = $('#oldpassword').val();
        if (oldpassword.length == 0) {
            alert('原密码为空！');
//            $('#changePasswordModal').modal('toggle');
            return;
        }
        var password1 = $('#newpassword').val();
        var password2 = $('#newpassword2').val();
        if (password1.length == 0) {
            alert('新密码为空！');
            return;
        }
        if (password1 != password2) {
            alert('两次密码内容不一致！');
            return;
        }

        $.post(ctx + '/user/modify-password/${user.id}/' + oldpassword + '/' + password1,
                function(resp) {
                    if (resp == 'success') {
                        alert('密码已修改!');
                    } else {
                        alert('操作失败!');
                    }
                    $('#changePasswordModal').modal('toggle');
                });
    });

    $('.change-password').click(function() {
        $('#changePasswordModal').modal('toggle');
    });

    var globalTimer;
    function timeCount() {
        $.ajax({
            type: 'post',
            async: true,
            url: ctx + '/news/message/count/inbox',
            contentType: "application/json; charset=utf-8",
            success: function (resp) {
                if (resp.length < 10) {
                    $('#message-count').text(resp);
                }
            },
            error: function () {
//                alert('articleTodo error!!');
            }
        });

        var total_jobs = 0;
        $.ajax({
            type: 'post',
            async: false,
            url: ctx + '/news/topic/count/task',
            contentType: "application/json; charset=utf-8",
            success: function (resp) {
                if (resp == "0")
                    $('#header-todo-topic').text("没有待办新闻选题任务");
                else {
                    $('#header-todo-topic').text("有 " + resp + " 条待办新闻选题任务");
                    total_jobs = total_jobs + parseInt(resp);
                }
            },
            error: function () {
//                alert('todo topic error!!');
            }
        });
        $.ajax({
            type: 'post',
            async: false,
            url: ctx + '/news/article/count/task',
            contentType: "application/json; charset=utf-8",
            success: function (resp) {
                if (resp == "0")
                    $('#header-todo-article').text("没有待办新闻文稿任务");
                else {
                    $('#header-todo-article').text("有 " + resp + " 条待办新闻文稿任务");
                    total_jobs = total_jobs + parseInt(resp);
                }
            },
            error: function () {
//                alert('todo article error!!');
            }
        });
        $.ajax({
            type: 'post',
            async: false,
            url: ctx + '/news/storyboard/count/task',
            contentType: "application/json; charset=utf-8",
            success: function (resp) {
                if (resp == "0")
                    $('#header-todo-storyboard').text("没有待办新闻串联单任务");
                else {
                    $('#header-todo-storyboard').text("有 " + resp + " 条待办新闻串联单任务");
                    total_jobs = total_jobs + parseInt(resp);
                }
            },
            error: function () {
//                alert('todo storyboard error!!');
            }
        });
        $.ajax({
            type: 'post',
            async: false,
            url: ctx + '/news/topic/count/need-job',
            contentType: "application/json; charset=utf-8",
            success: function (resp) {
                if (resp == "0")
                    $('#header-need-job-topic').text("没有需要完善的新闻选题");
                else {
                    $('#header-need-job-topic').text("有 " + resp + " 条新闻选题需要完善");
                    total_jobs = total_jobs + parseInt(resp);
                }
            },
            error: function () {
//                alert('need job topic error!!');
            }
        });

        $("#todo-count").text(total_jobs);


        //  query jobs every 30 seconds
        globalTimer = setTimeout(timeCount, 30000);
    }

    $(function () {
        timeCount();
    });

</script>
<!-- / END - page related files and scripts [optional] -->
