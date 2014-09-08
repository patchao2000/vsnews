<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-9-5
  Time: 下午4:40
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--@elvariable id="msg" type="com.videostar.vsnews.entity.news.NewsMessage"--%>
<%--@elvariable id="userList" type="java.util.list"--%>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>发送留言</title>
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
                    <div class='box'>
                        <div class='box-header blue-background'>
                            <div class='title'>
                                <div class='icon-edit'></div>发送留言
                            </div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content'>
                            <form:form modelAttribute="msg" id="messageForm" action="${ctx}/news/message/start" class="form form-horizontal"
                                       style="margin-bottom: 0;" method="post" accept-charset="UTF-8">

                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='message_receiverId'>发送给：</label>
                                    <div class='col-md-10'>
                                        <form:select class='select2 form-control' id="message_receiverId" path="receiverId">
                                            <form:options items="${userList}" itemValue="userId" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <%--<div class='form-group'>--%>
                                    <%--<label class='col-md-2 control-label' for='message_title'>标题：</label>--%>
                                    <%--<div class='col-md-10'>--%>
                                        <%--<form:input class='form-control' id='message_title' path='title' type='text' />--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='message_content'>内容：</label>
                                    <div class='col-md-10'>
                                        <form:textarea class='form-control' id='message_content' path='content' rows='5' />
                                        <form:errors path="content" cssClass="help-block" />
                                    </div>
                                </div>
                                <div class='form-actions form-actions-padding-sm'>
                                    <div class='row'>
                                        <div class='col-md-10 col-md-offset-2'>
                                            <button class='btn btn-primary' type='submit'><i class='icon-save'></i>提交</button>
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

    $(function () {
        $("#messageForm").submit(function (event) {
        });
    });

</script>

</body>
</html>