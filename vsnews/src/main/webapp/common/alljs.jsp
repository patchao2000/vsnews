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
<%--<script src="${ctx}/assets/javascripts/plugins/flot/excanvas.js" type="text/javascript"></script>--%>
<%--<script src="${ctx}/assets/javascripts/plugins/flot/flot.min.js" type="text/javascript"></script>--%>
<%--<script src="${ctx}/assets/javascripts/plugins/flot/flot.resize.js" type="text/javascript"></script>--%>
<!-- / END - page related files and scripts [optional] -->
<script>
    Date.prototype.format = function(format) {
        var o = {
            "M+": this.getMonth() + 1, //month
            "d+": this.getDate(), //day
            "h+": this.getHours(), //hour
            "m+": this.getMinutes(), //minute
            "s+": this.getSeconds(), //second
            "q+": Math.floor((this.getMonth() + 3) / 3), //quarter
            "S": this.getMilliseconds() //millisecond
        }
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
</script>
<!-- / END - page related files and scripts [optional] -->
