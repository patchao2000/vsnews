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
                            <form class="form form-horizontal" style="margin-bottom: 0;" method="post" accept-charset="UTF-8">
                                <div class='form-group'>
                                    <c:if test="${storyboard.lockerUserId == null}">
                                        <div class='col-md-4'>
                                            <a id="lock" class="btn btn-success" title='锁定' href="#"><i class="icon-edit icon-white"></i> 进入编辑模式</a>
                                        </div>
                                    </c:if>
                                    <c:if test="${storyboard.lockerUserId != null}">
                                        <%--@elvariable id="alltopics" type="java.util.List"--%>
                                        <%--@elvariable id="topic" type="com.videostar.vsnews.entity.news.NewsTopic"--%>
                                        <label class='col-md-2 control-label' for='storyboard_topic'>新闻选题：</label>
                                        <div class='col-md-4'>
                                            <select class='select2 form-control' id="storyboard_topic">
                                                <c:forEach items="${alltopics }" var="topic">
                                                    <option value="${topic.uuid}">${topic.title}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <a id="addtopic" class="btn btn-success" title='添加新闻选题' href="#"><i class="icon-plus icon-white"></i> 添加</a>
                                        <a id="unlock" class="btn btn-success" title='解锁' href="#"><i class="icon-edit icon-white"></i> 退出编辑模式</a>
                                    </c:if>
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
                                                <c:if test="${storyboard.lockerUserId != null}">
                                                <th>操作</th>
                                                </c:if>
                                            </tr>
                                            </thead>
                                            <tbody>

                                            <%--@elvariable id="topics" type="java.util.list"--%>
                                            <%--@elvariable id="detail" type="com.videostar.vsnews.web.news.TopicInfoDetail"--%>
                                            <c:forEach items="${topics }" var="detail">
                                                <tr data-index="${detail.orderValue }">
                                                    <td>${detail.orderValue + 1}</td>
                                                    <td>${detail.topic.title }</td>
                                                    <td>
                                                        <c:if test="${detail.videoFileReady == true}"><a class='btn btn-success btn-xs' href='#'><i class='icon-ok'></i></a></c:if>
                                                    </td>
                                                    <td>
                                                        <c:if test="${detail.audioFileReady == true}"><a class='btn btn-success btn-xs' href='#'><i class='icon-ok'></i></a></c:if>
                                                    </td>
                                                    <td>
                                                        <c:if test="${detail.articleReady == true}"><a class='btn btn-success btn-xs' href='#'><i class='icon-ok'></i></a></c:if>
                                                    </td>
                                                    <td>${detail.adjustTC}</td>

                                                    <c:if test="${storyboard.lockerUserId != null}">
                                                    <td>
                                                        <a class="uptopic btn btn-primary btn-xs" href="#"><i class="icon-level-up"></i>上移</a>
                                                        <a class="downtopic btn btn-info btn-xs" href="#"><i class="icon-level-down"></i>下移</a>
                                                        <a class="removetopic btn btn-danger btn-xs" href="#"><i class="icon-remove"></i>删除</a>
                                                    </td>
                                                    </c:if>
                                                </tr>
                                            </c:forEach>
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

    $("#lock").live("click",function(){
        $.ajax({
            type: 'post',
            async: false,
            url: ctx + '/news/storyboard/lock/' + ${storyboard.id},
            contentType: "application/json; charset=utf-8",
            success: function (resp) {
                if (resp == 'success') {
//                    alert('任务完成');
                    location.href = ctx + '/news/storyboard/edit/' + ${storyboard.id};
                } else {
                    alert('操作失败!');
                }
            },
            error: function () {
                alert('操作失败!!');
            }
        });
    });

    $("#unlock").live("click",function(){
        $.ajax({
            type: 'post',
            async: false,
            url: ctx + '/news/storyboard/unlock/' + ${storyboard.id},
            contentType: "application/json; charset=utf-8",
            success: function (resp) {
                if (resp == 'success') {
//                    alert('任务完成');
                    location.href = ctx + '/news/storyboard/edit/' + ${storyboard.id};
                } else {
                    alert('操作失败!');
                }
            },
            error: function () {
                alert('操作失败!!');
            }
        });
    });

    $(".uptopic").live("click",function(){
        $.ajax({
            type: 'post',
            async: false,
            url: ctx + '/news/storyboard/topicup/' + ${storyboard.id} + '/' + $(this).parents('tr').attr('data-index'),
            contentType: "application/json; charset=utf-8",
            success: function (resp) {
                if (resp == 'success') {
//                    alert('任务完成');
                    location.href = ctx + '/news/storyboard/edit/' + ${storyboard.id};
                } else {
                    alert('操作失败!');
                }
            },
            error: function () {
                alert('操作失败!!');
            }
        });
    });

    $(".downtopic").live("click",function(){
        $.ajax({
            type: 'post',
            async: false,
            url: ctx + '/news/storyboard/topicdown/' + ${storyboard.id} + '/' + $(this).parents('tr').attr('data-index'),
            contentType: "application/json; charset=utf-8",
            success: function (resp) {
                if (resp == 'success') {
//                    alert('任务完成');
                    location.href = ctx + '/news/storyboard/edit/' + ${storyboard.id};
                } else {
                    alert('操作失败!');
                }
            },
            error: function () {
                alert('操作失败!!');
            }
        });
    });

    $(".removetopic").live("click",function(){
        $.ajax({
            type: 'post',
            async: false,
            url: ctx + '/news/storyboard/topicremove/' + ${storyboard.id} + '/' + $(this).parents('tr').attr('data-index'),
            contentType: "application/json; charset=utf-8",
            success: function (resp) {
                if (resp == 'success') {
//                    alert('任务完成');
                    location.href = ctx + '/news/storyboard/edit/' + ${storyboard.id};
                } else {
                    alert('操作失败!');
                }
            },
            error: function () {
                alert('操作失败!!');
            }
        });
    });

    $("#addtopic").live("click",function(){
//        alert($('#storyboard_topic' + ' :selected').val());
        $.ajax({
            type: 'post',
            async: false,
            url: ctx + '/news/storyboard/addtopic/' + ${storyboard.id} + '/' + $('#storyboard_topic' + ' :selected').val(),
            contentType: "application/json; charset=utf-8",
            success: function (resp) {
                if (resp == 'success') {
                    alert('任务完成');
                    location.href = ctx + '/news/storyboard/edit/' + ${storyboard.id};
                } else {
                    alert('操作失败!');
                }
            },
            error: function () {
                alert('操作失败!!');
            }
        });
    });

    $(function () {
        $("#storyboard_columnId").select2("readonly", true);
        $("#article_editors").select2("readonly", true);
    });

</script>

</body>
</html>