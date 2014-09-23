<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-9-23
  Time: 下午10:18
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--@elvariable id="storyboard" type="com.videostar.vsnews.entity.news.NewsStoryboard"--%>
<%--@elvariable id="title" type="java.lang.String"--%>
<%--@elvariable id="editors" type="java.util.List"--%>
<%--@elvariable id="columns" type="java.util.map"--%>
<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>${title}</title>
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
                                <div class='icon-edit'></div>
                                ${title}
                            </div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content'>
                            <form:form modelAttribute="storyboard" id="inputForm" action="#" class="form form-horizontal"
                                       style="margin-bottom: 0;" method="post" accept-charset="UTF-8">

                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_title'>标题：</label>
                                    <div class='col-md-10'>
                                        <form:input class='form-control' id='storyboard_title' path='title' type='text' readonly="true" />
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
                                            <form:input class='form-control' id='storyboard_airDate' path='airDate' type='text' readonly="true" />
                                            <span class='input-group-addon'>
                                                <span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_startTC'>开始时段：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='storyboard_startTC' path='startTC' type='text' readonly="true" />
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_endTC'>结束时段：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='storyboard_endTC' path='endTC' type='text' readonly="true" />
                                    </div>
                                </div>
                            </form:form>
                        </div>
                    </div>

                    <div class='box'>
                        <div class='box-header blue-background'>
                            <div class='title'>
                                <div class='icon-edit'></div>内容</div>
                            <div class='actions'>
                                <a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
                                </a>
                            </div>
                        </div>
                        <div class='box-content'>
                            <form class="form form-horizontal"
                                   style="margin-bottom: 0;" method="post" accept-charset="UTF-8">
                                <div class='form-group'>
                                    <%--@elvariable id="topics" type="java.util.List"--%>
                                    <%--@elvariable id="topic" type="com.videostar.vsnews.entity.news.NewsTopic"--%>
                                    <label class='col-md-2 control-label' for='storyboard_topic'>新闻选题：</label>
                                    <div class='col-md-4'>
                                        <select class='select2 form-control' id="storyboard_topic">
                                            <c:forEach items="${topics }" var="topic">
                                                <option value="${topic.uuid}">${topic.title}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <a id="addtopic" class="btn btn-success" title='添加新闻选题' href="#"><i class="icon-plus icon-white"></i> 添加</a>
                                </div>
                                <div class='responsive-table'>
                                    <div class='scrollable-area'>
                                        <table class='table table-bordered table-striped' style='margin-bottom:0;'>
                                            <thead>
                                            <tr>
                                                <th>序号</th>
                                                <th>标题</th>
                                                <th>视频文件</th>
                                                <th>音频文件</th>
                                                <th>文稿</th>
                                                <th>总长度</th>
                                                <th>操作</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td>1</td>
                                                <td>Sample</td>
                                                <td><a class='btn btn-success btn-xs' href='#'><i class='icon-ok'></i></a></td>
                                                <td><a class='btn btn-danger btn-xs' href='#'><i class='icon-remove'></i></a></td>
                                                <td><a class='btn btn-success btn-xs' href='#'><i class='icon-ok'></i></a></td>
                                                <td>00:00:00:00</td>
                                                <td>
                                                    <a class="uptopic btn btn-primary btn-xs" href="#"><i class="icon-level-up"></i>上移</a>
                                                    <a class="downtopic btn btn-info btn-xs" href="#"><i class="icon-level-down"></i>下移</a>
                                                    <a class="removetopic btn btn-danger btn-xs" href="#"><i class="icon-remove"></i>删除</a>
                                                </td>
                                            </tr>
                                            <%--@elvariable id="list" type="java.util.List"--%>
                                            <%--@elvariable id="detail" type="com.videostar.vsnews.web.news.StoryboardDetail"--%>
                                            <%--<c:forEach items="${list }" var="detail">--%>
                                                <%--<tr id="${detail.storyboard.id }">--%>
                                                    <%--<td>${detail.userName }</td>--%>
                                                    <%--<td>${detail.columnName }</td>--%>
                                                    <%--<td><fmt:formatDate value="${detail.storyboard.airDate}" pattern="yyyy-MM-dd HH:mm" /></td>--%>
                                                    <%--<td>${detail.storyboard.title }</td>--%>
                                                    <%--<td>${detail.storyboard.startTC }</td>--%>
                                                    <%--<td>${detail.storyboard.endTC }</td>--%>
                                                    <%--<td>--%>
                                                        <%--<a class="viewstoryboard btn btn-primary btn-xs" href="#"><i class="icon-edit"></i>查看</a>--%>
                                                        <%--<a class="editstoryboard btn btn-primary btn-xs" href="#"><i class="icon-edit"></i>编辑</a>--%>
                                                    <%--</td>--%>
                                                <%--</tr>--%>
                                            <%--</c:forEach>--%>
                                            </tbody>
                                        </table>
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

<script type="text/javascript">

    $(function () {
        $("#storyboard_columnId").select2("readonly", true);
        $("#article_editors").select2("readonly", true);
    });

</script>

</body>
</html>