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
<%--@elvariable id="technicians" type="java.util.List"--%>
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
                                    <label class='col-md-2 control-label' for='storyboard_studio'>演播室：</label>
                                    <div class='col-md-4'>
                                        <form:input class='form-control' id='storyboard_studio' path='studio' type='text' readonly="true" />
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
                                <hr class='hr-normal'>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_eic'>责编：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_eic" multiple="true" path="editorsInCharge">
                                            <form:options items="${editors}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_instructors'>导播：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_instructors" multiple="true" path="instructors">
                                            <form:options items="${editors}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_editors'>记者：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_editors" multiple="true" path="editors">
                                            <form:options items="${editors}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_producers'>监制：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_producers" multiple="true" path="producers">
                                            <form:options items="${editors}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_directors'>主任：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_directors" multiple="true" path="directors">
                                            <form:options items="${editors}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_announcers'>播音员：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_announcers" multiple="true" path="announcers">
                                            <form:options items="${technicians}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_voiceActors'>配音员：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_voiceActors" multiple="true" path="voiceActors">
                                            <form:options items="${technicians}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_subtitlers'>字幕员：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_subtitlers" multiple="true" path="subtitlers">
                                            <form:options items="${technicians}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_cameramen'>摄影师：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_cameramen" multiple="true" path="cameramen">
                                            <form:options items="${technicians}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_lightingEngineers'>灯光：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_lightingEngineers" multiple="true" path="lightingEngineers">
                                            <form:options items="${technicians}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                    <label class='col-md-2 control-label' for='storyboard_technicians'>技术：</label>
                                    <div class='col-md-2'>
                                        <form:select class='select2 form-control' id="storyboard_technicians" multiple="true" path="technicians">
                                            <form:options items="${technicians}" itemValue="id" itemLabel="firstName" />
                                        </form:select>
                                    </div>
                                </div>
                                <hr class='hr-normal'>
                                <div class='form-group'>
                                    <label class='col-md-2 control-label' for='storyboard_notes'>备注：</label>
                                    <div class='col-md-10'>
                                        <form:textarea class='form-control' id='storyboard_notes' path='notes' readonly="true" rows='3' />
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
                                        <a id="add_topic" class="btn btn-success" title='添加新闻选题' href="#"><i class="icon-plus icon-white"></i> 添加</a>
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
                                                <th>文稿状态</th>
                                                <th>文字长度</th>
                                                <th>视频长度</th>
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
                                                <tr data-index="${detail.orderValue }" data-article-id='<c:if test="${detail.article != null}">${detail.article.id}</c:if>'>
                                                    <td>${detail.orderValue + 1}</td>
                                                    <td>${detail.topic.title }</td>
                                                    <td>
                                                        <c:if test="${detail.videoFileReady == true}"><a class='btn btn-success btn-xs' href='#'><i class='icon-ok'></i></a></c:if>
                                                    </td>
                                                    <td>
                                                        <c:if test="${detail.audioFileReady == true}"><a class='btn btn-success btn-xs' href='#'><i class='icon-ok'></i></a></c:if>
                                                    </td>
                                                    <td>
                                                        <%--<c:if test="${detail.article != null}"><a class='btn btn-success btn-xs' href='#'><i class='icon-ok'></i></a></c:if>--%>
                                                        <c:if test="${detail.article != null}">
                                                            <c:choose>
                                                                <c:when test="${detail.article.task != null}">${detail.article.task.name }</c:when>
                                                                <c:otherwise>已完成</c:otherwise>
                                                            </c:choose>
                                                        </c:if>
                                                    </td>
                                                    <td>${detail.articleLength}</td>
                                                    <td>${detail.videoLength}</td>
                                                    <td>${detail.totalLength}</td>

                                                    <c:if test="${storyboard.lockerUserId != null}">
                                                    <td>
                                                        <c:if test="${detail.article != null}">
                                                            <a class='view_article btn btn-success btn-xs' href='#'>查看文稿</a>
                                                        </c:if>
                                                        <a class="up_topic btn btn-primary btn-xs" href="#"><i class="icon-level-up"></i>上移</a>
                                                        <a class="down_topic btn btn-info btn-xs" href="#"><i class="icon-level-down"></i>下移</a>
                                                        <a class="remove_topic btn btn-danger btn-xs" href="#"><i class="icon-remove"></i>删除</a>
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

    $(".up_topic").live("click",function(){
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

    $(".down_topic").live("click",function(){
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

    $(".remove_topic").live("click",function(){
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

    $("#add_topic").live("click",function(){
        var selected = $('#storyboard_topic' + ' :selected');
        if (selected.size() == 0) {
            return;
        }
        $.ajax({
            type: 'post',
            async: false,
            url: ctx + '/news/storyboard/addtopic/' + ${storyboard.id} + '/' + selected.val(),
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

    $(".view_article").live("click",function(){
        var id = $(this).parents('tr').attr('data-article-id');
        if (id.length > 0) {
            location.href = ctx + '/news/article/view/' + id;
        }
    });

    $(function () {
        $("#storyboard_columnId").select2("readonly", true);
        $("#storyboard_editors").select2("readonly", true);
        $("#storyboard_eic").select2("readonly", true);
        $("#storyboard_instructors").select2("readonly", true);
        $("#storyboard_producers").select2("readonly", true);
        $("#storyboard_directors").select2("readonly", true);
        $("#storyboard_announcers").select2("readonly", true);
        $("#storyboard_voiceActors").select2("readonly", true);
        $("#storyboard_subtitlers").select2("readonly", true);
        $("#storyboard_cameramen").select2("readonly", true);
        $("#storyboard_lightingEngineers").select2("readonly", true);
        $("#storyboard_technicians").select2("readonly", true);
    });

</script>

</body>
</html>