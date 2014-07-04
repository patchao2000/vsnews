<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<header>
    <nav class='navbar navbar-default navbar-fixed-top'>
        <a class='navbar-brand' href='index.html'>
            <img width="81" height="21" class="logo" alt="Flatty" src="${ctx}/assets/images/logo.svg"/>
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
                    <span class='user-name'>${user.id }</span>
                    <b class='caret'></b>
                </a>
                <ul class='dropdown-menu'>
                    <li>
                        <a href='user_profile.html'>
                            <i class='icon-user'></i>
                            用户资料
                        </a>
                    </li>
                    <li>
                        <a href='user_profile.html'>
                            <i class='icon-cog'></i>
                            用户设置
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
        <form action='search_results.html' class='navbar-form navbar-right hidden-xs' method='get'>
            <button class='btn btn-link icon-search' name='button' type='submit'></button>
            <div class='form-group'>
                <input value="" class="form-control" placeholder="搜索..." autocomplete="off" id="q_header" name="q"
                       type="text"/>
            </div>
        </form>
    </nav>
</header>
