<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html lang="en">
<head>
    <%@ include file="/common/global.jsp" %>
    <%@ include file="/common/meta.jsp" %>
    <title>登录页</title>
    <script>
        var logon = ${not empty user};
        if (logon) {
            location.href = '${ctx}/main/index';
        }
    </script>
    <link href="${ctx }/js/common/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        body {
            padding-top: 40px;
            padding-bottom: 40px;
            /*background-color: #eee;*/
        }

        .alert {
            max-width: 400px;
            padding: 15px;
            margin: 0 auto;
        }

        .form-signin {
            max-width: 330px;
            padding: 15px;
            margin: 0 auto;
        }

        .form-signin .form-signin-heading,
        .form-signin .checkbox {
            margin-bottom: 10px;
        }

        .form-signin .checkbox {
            font-weight: normal;
        }

        .form-signin .form-control {
            position: relative;
            font-size: 16px;
            height: auto;
            padding: 10px;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }

        .form-signin .form-control:focus {
            z-index: 2;
        }

        .form-signin input[type="text"] {
            margin-bottom: -1px;
            border-bottom-left-radius: 0;
            border-bottom-right-radius: 0;
        }

        .form-signin input[type="password"] {
            margin-bottom: 10px;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
        }

        html,
        body {
            height: 100%;
            /* The html and body elements cannot have any padding or margin. */
        }

        #wrap {
            min-height: 100%;
            height: auto;
            /* Negative indent footer by its height */
            margin: 0 auto -60px;
            /* Pad bottom by footer height */
            padding: 0 0 60px;
        }

        /* Set the fixed height of the footer here */
        #footer {
            height: 60px;
            background-color: #f5f5f5;
        }

        .text-muted {
            margin: 20px 0;
        }
    </style>

    <script src="${ctx }/js/common/jquery-1.11.1.js" type="text/javascript"></script>
    <script src="${ctx }/js/common/bootstrap/js/bootstrap.min.js"></script>
</head>

<body>
<div id="wrap">
    <div id="loginContainer" class="login-center">
        <c:if test="${not empty param.error}">
            <div id="error" class="alert alert-danger">用户名或密码错误！！！</div>
        </c:if>
        <c:if test="${not empty param.timeout}">
            <div id="error" class="alert alert-warning">未登录或超时！！！</div>
        </c:if>

        <div class="container">
            <form class="form-signin" role="form" action="${ctx }/user/logon" method="get">
                <h2 class="form-signin-heading">VSNews</h2>
                <input id="username" name="username" type="text" class="form-control" placeholder="用户名" required
                       autofocus>
                <input id="password" name="password" type="password" class="form-control" placeholder="密码" required>
                <label class="checkbox">
                    <input type="checkbox" value="remember-me"> 记住我
                </label>
                <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
            </form>
        </div>
    </div>
</div>
<div id="footer">
    <div class="container">
        <p class="text-muted">组件版本信息 [ Activiti版本: ${prop['activiti.version']}, Spring版本: ${prop['spring.version']}
            ]</p>
    </div>
</div>
</body>
</html>
