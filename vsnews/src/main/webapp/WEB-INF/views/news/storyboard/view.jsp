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
<%--@elvariable id="editors" type="java.util.List"--%>
<%--@elvariable id="columns" type="java.util.map"--%>
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
        <c:set var="action" value="${ctx}/news/storyboard/save"/>
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
                                <div class='form-actions form-actions-padding-sm'>
                                    <div class='row'>
                                        <div class='col-md-10 col-md-offset-2'>
                                            <c:if test="${createMode == true}">
                                                <button class='btn btn-primary' type='submit'><i class='icon-save'></i>提交</button>
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

    $(function () {
        <c:if test="${readonly == true}">
        $("#storyboard_columnId").select2("readonly", true);
        $("#article_editors").select2("readonly", true);
        </c:if>
    });

</script>

</body>
</html>