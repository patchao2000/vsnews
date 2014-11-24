<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<header>
    <nav class='navbar navbar-default navbar-fixed-top'>
        <a class='navbar-brand' href='index.html'>
            <%--<img width="81" height="21" class="logo" alt="Flatty" src="${ctx}/assets/images/vsnews.png"/>--%>
            <img width="21" height="21" class="logo-xs" alt="Flatty" src="${ctx}/assets/images/logo_xs.svg"/>
        </a>
        <a class='toggle-nav btn pull-left' href='#'>
            <i class='icon-reorder'></i>
        </a>
        <ul class='nav'>
            <li class='dropdown light only-icon'>
                <a class='dropdown-toggle' data-toggle='dropdown' href='#'>
                    <i class='icon-cog'></i>
                </a>
                <ul class='dropdown-menu color-settings'>
                    <li class='color-settings-body-color'>
                    <div class='color-title'>Body color</div>
                    <a data-change-to='${ctx}/assets/stylesheets/light-theme.css' href='#'>
                    Light
                    <small>(default)</small>
                    </a>
                    <a data-change-to='${ctx}/assets/stylesheets/dark-theme.css' href='#'>
                    Dark
                    </a>
                    <a data-change-to='${ctx}/assets/stylesheets/dark-blue-theme.css' href='#'>
                    Dark blue
                    </a>
                    </li>
                    <li class='divider'></li>
                    <li class='color-settings-contrast-color'>
                        <div class='color-title'>Contrast color</div>
                        <a data-change-to="contrast-red" href="#"><i class='icon-cog text-red'></i>
                            Red
                            <small>(default)</small>
                        </a>

                        <a data-change-to="contrast-blue" href="#"><i class='icon-cog text-blue'></i>
                            Blue
                        </a>

                        <a data-change-to="contrast-orange" href="#"><i class='icon-cog text-orange'></i>
                            Orange
                        </a>

                        <a data-change-to="contrast-purple" href="#"><i class='icon-cog text-purple'></i>
                            Purple
                        </a>

                        <a data-change-to="contrast-green" href="#"><i class='icon-cog text-green'></i>
                            Green
                        </a>

                        <a data-change-to="contrast-muted" href="#"><i class='icon-cog text-muted'></i>
                            Muted
                        </a>

                        <a data-change-to="contrast-fb" href="#"><i class='icon-cog text-fb'></i>
                            Facebook
                        </a>

                        <a data-change-to="contrast-dark" href="#"><i class='icon-cog text-dark'></i>
                            Dark
                        </a>

                        <a data-change-to="contrast-pink" href="#"><i class='icon-cog text-pink'></i>
                            Pink
                        </a>

                        <a data-change-to="contrast-grass-green" href="#"><i class='icon-cog text-grass-green'></i>
                            Grass green
                        </a>

                        <a data-change-to="contrast-sea-blue" href="#"><i class='icon-cog text-sea-blue'></i>
                            Sea blue
                        </a>

                        <a data-change-to="contrast-banana" href="#"><i class='icon-cog text-banana'></i>
                            Banana
                        </a>

                        <a data-change-to="contrast-dark-orange" href="#"><i class='icon-cog text-dark-orange'></i>
                            Dark orange
                        </a>

                        <a data-change-to="contrast-brown" href="#"><i class='icon-cog text-brown'></i>
                            Brown
                        </a>

                    </li>
                </ul>
            </li>
            <li class='dropdown dark user-menu'>
                <a class='dropdown-toggle' data-toggle='dropdown' href='#'>
                    <img width="23" height="23" alt="${user.id }" src="${ctx}/assets/images/avatar.gif"/>
                    <span class='user-name'>${user.firstName }</span>
                    <b class='caret'></b>
                </a>
                <ul class='dropdown-menu'>
                    <li>
                        <a href='#'>
                        <%--<a href='user_profile.html'>--%>
                            <i class='icon-user'></i>
                            用户资料
                        </a>
                    </li>
                    <li>
                        <a class='change-password' href='#'>
                            <i class='icon-cog'></i>
                            修改密码
                        </a>
                    </li>
                    <li class='divider'></li>
                    <li>
                        <a href='#' id="loginOut">
                            <i class='icon-signout'></i>
                            退出
                        </a>
                    </li>
                </ul>
            </li>
        </ul>
        <%--<form action='search_results.html' class='navbar-form navbar-right hidden-xs' method='get'>--%>
            <%--<button class='btn btn-link icon-search' name='button' type='submit'></button>--%>
            <%--<div class='form-group'>--%>
                <%--<input value="" class="form-control" placeholder="搜索..." autocomplete="off" id="q_header" name="q"--%>
                       <%--type="text"/>--%>
            <%--</div>--%>
        <%--</form>--%>
    </nav>
</header>

<div class="modal fade user-dialog" id="changePasswordModal" tabindex="-1" role="dialog" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="changePasswordModalLabel">修改密码</h4>
            </div>
            <div class="modal-body">
                <table>
                    <tbody>
                    <tr>
                        <td>请输入原密码：</td>
                        <td>
                            <%--<label for='password'></label>--%>
                            <input class='form-control' type="password" name="oldpassword" id="oldpassword" style="width:260px"></td>
                    </tr>
                    <tr>
                        <td>请输入新密码：</td>
                        <td>
                            <%--<label for='password'></label>--%>
                            <input class='form-control' type="password" name="password" id="password" style="width:260px"></td>
                    </tr>
                    <tr>
                        <td>请再次输入新密码：</td>
                        <td>
                            <%--<label for='password2'></label>--%>
                            <input class='form-control' type="password" name="password2" id="password2" style="width:260px"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save-password"><i class='icon-save'></i> 保存</button>
            </div>
        </div>
    </div>
</div>

