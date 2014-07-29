<%--
  Created by IntelliJ IDEA.
  User: patchao2000
  Date: 14-7-28
  Time: 下午10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<table class='table table-striped'>
    <tr>
        <td>申请人：</td>
        <td><input class="form-control" type="text" data-name="userId"></td>
    </tr>
    <tr>
        <td>申请时间：</td>
        <td><input class="form-control" type="text" data-name="applyTime"></td>
    </tr>
    <tr>
        <td>主标题：</td>
        <td><input class="form-control" type="text" data-name="mainTitle"></td>
    </tr>
    <tr>
        <td>副标题：</td>
        <td><input class="form-control" type="text" data-name="subTitle"></td>
    </tr>
    <tr>
        <td>内容：</td>
        <td><textarea class='form-control' rows='3' data-name="content"></textarea></td>
    </tr>
    <tr>
        <td>备注：</td>
        <td><input class="form-control" type="text" data-name="notes"></td>
    </tr>
</table>
