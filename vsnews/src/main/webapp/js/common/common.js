/**
 * 公共函数库，主要是一些JS工具函数，各种插件的公共设置
 * @author HenryYan
 */
(function($) {

    $.common = {};

    //-- 初始化方法 --//
    _initFunction();

    //-- 窗口工具 --//
    $.common.window = {
        //-- 获得最上层的window对象 --//
        getTopWin: function() {
            if (parent) {
                var tempParent = parent;
                while (true) {
                    $.common.plugin$.common.plugin
                    if (tempParent.parent) {
                        if (tempParent.parent == tempParent) {
                            break;
                        }
                        tempParent = tempParent.parent;
                    } else {
                        break;
                    }
                }
                return tempParent;
            } else {
                return window;
            }
        },
        // 获取可见区域的宽度
        getClientWidth: function() {
            return document.documentElement.clientWidth - 10;
        },
        // 获取可见区域的高度
        getClientHeight: function(options) {
            var defaults = {
                autoSuit: true, // 自动适应高度，因为在firefox下面不减10会出现滚动条
                autoSuitValue: -13
            };
            options = $.extend({}, defaults, options);
            if (options.autoSuit) {
                return document.documentElement.clientHeight + options.autoSuitValue;
            } else {
                return document.documentElement.clientHeight;
            }
        }
    };

    /*******************************************/
    /**			jQuery UI--开始	  			  **/
    /*******************************************/
    var _plugin_jqui = {

        /**
         * 按钮相关
         */
        button: {
            onOff: function(options) {
                var defaults = {
                    btnText: false // text
                };
                options = $.extend({}, defaults, options);
                var dlgButton = $('.ui-dialog-buttonpane button');
                if (options.btnText) {
                    // TODO 查询优化，兼容有相同文字的情况
                    dlgButton = $('.ui-button-text:contains(' + options.btnText + ')').parent();
                }
                if (options.enable) {
                    dlgButton.attr('disabled', '');
                    dlgButton.removeClass('ui-state-disabled');
                } else {
                    dlgButton.attr('disabled', 'disabled');
                    dlgButton.addClass('ui-state-disabled');
                }
            }
        },

        /**
         * 对话框相关
         */
        dialog: {
        	event: {
				close: function() {
					$(this).dialog('close');
				}
			},
            /**
             * 按钮相关方法
             */
            button: {
                /**
                 * 为dialog中的button设置icon，参数结构
                 * [{
                 *     text: '暂存',
                 *     title: '暂时存储',
                 *     icons: {
                 *         primary: 'ui-icon-disk'
                 *     }
                 * }]
                 * @param {Object} options
                 */
                setAttrs: function(options) {
                    var _set_btns = [];
                    $.each(options, function(i, v) {
                        _set_btns[_set_btns.length] = v;
                    });
                    $.each(_set_btns, function(i, v) {
                        var $btn = $('.ui-button-text').filter(function() {
                            return $(this).text() == v.text;
                        }).parent();
                        var _icons = {};
                        if (v.icons) {
                            var arrayIcons = v.icons.split(' ');
                            if (arrayIcons.length == 1) {
                                _icons.primary = arrayIcons[0];
                            } else if (arrayIcons.length == 2) {
                                _icons.primary = arrayIcons[0];
                                _icons.secondary = arrayIcons[1];
                            }
                            $btn.button({
                                icons: _icons
                            });
                        }
                        $btn.attr('title', v.title);

                        // 分隔符
                        try {
                            if (v.division) {
                                var position = v.division || 'after';
                                if (position == 'before') {
                                    $btn.before("<span class='ui-state-error ui-dialog-button-devision'></span>");
                                } else if (position == 'after') {
                                    $btn.after("<span class='ui-state-error ui-dialog-button-devision'></span>");
                                } else {
                                    alert('未知位置：' + position);
                                }
                            }
                        } catch (e) {
                        }
                    });
                },

                /*[{
                 text: 'aaa',
                 position: ['left'|'right']
                 }]*/
                group: function(opts) {
                    $.each(opts, function(i, v) {
                        var $btn = $('.ui-button-text').filter(function() {
                            return $(this).text() == v.text;
                        }).parent();
                        try {
                            if (!v.position || v.position == 'after') {
                                $btn.after("<span class='ui-state-error ui-dialog-button-devision'></span>");
                            } else if (v.position == 'before') {
                                $btn.before("<span class='ui-state-error ui-dialog-button-devision'></span>");
                            } else {
                                alert('请设置position|by dialog.button.group');
                            }
                        } catch (e) {
                        }
                    });
                }
            },
            /**
             * 根据浏览器差异获取window的高度
             */
            getBodyHeight: function() {
                var tempBodyHeight = document.documentElement.clientHeight;
                if ($.common.browser.isIE()) {
                    //tempBodyHeight += 150;
                } else {
                    tempBodyHeight -= 10;
                }
                return tempBodyHeight;
            },

            /**
             * 根据浏览器差异获取设置对话框的高度
             */
            getHeight: function(_height) {
                var tempBodyHeight = _height;
                if ($.common.browser.isIE()) {
                    tempBodyHeight += 100;
                } else {
                    tempBodyHeight -= 10;
                }
                return tempBodyHeight;
            }
        },

        /**
         * 选项卡相关
         */
        tab: {
            /**
             * 自动设置选项卡的高度
             * @param {Object} options
             */
            autoHeight: function(options) {
                var defaults = {
                    increment: {
                        ie: 0,
                        firefox: 0,
                        chrome: 0
                    }
                };

                options = $.extend({}, defaults, options);

                /**
                 * 核心处理函数
                 */
                function innerDeal() {
                    // 非IE默认值
                    var gap = 80;
                    // 特殊处理IE
                    if ($.common.browser.isIE()) {
                        gap = 60;
                        gap += options.increment.ie;
                    } else if ($.common.browser.isMozila()) {
                        gap += options.increment.firefox;
                    } else if ($.common.browser.isChrome()) {
                        gap += options.increment.chrome;
                    }

                    var height = document.body.clientHeight - gap;
                    $('.ui-tabs-panel').height(height);
                    if ($.isFunction(options.callback)) {
                        options.callback();
                    }
                }

                innerDeal();

                // 窗口大小改变的时候
                window.onresize = innerDeal;

            }
        },

		/**
		 * 一些特效
		 */
		effect: {

			/*
			 * 斑马效果
			 */
			zebra: function(selector) {
				$(selector).hover(function() {
					$(this).addClass('ui-state-hover');
				}, function() {
					$(this).removeClass('ui-state-hover');
				});
			}
		},

		/**
		 * 自动完成
		 */
		autocomplete: {

			/*
			 * 触发自动完成
			 */
			triggerSearch: function(e) {
				if ($(this).val().length > 0) {
            		$(this).autocomplete('search', $(this).val());
            	}
			},

			/*
			 * 取消自动完成的结果，配合triggerSearch使用，目的是针对文本框获取焦点之后就自动根据现有内容搜索后点击死循环问题
			 */
			cancelResult: function(ele) {
				setTimeout(function() {
					$('.ui-autocomplete').hide();
				}, 50);
			}
		}
    };
    /*******************************************/
    /**			jQuery UI--结束	  			  **/
    /*******************************************/

    /*******************************************/
    /**			workflow --开始	  			  **/
    /*******************************************/
    var _plugin_workflow = {
        setButtonIcons: function() {
            _plugin_jqui.dialog.button.setIcons({
                提交: {
                    primary: 'ui-icon-arrowthick-1-e'
                },
                退回: {
                    primary: 'ui-icon-arrowreturnthick-1-w'
                },
                流程跟踪: {
                    primary: 'ui-icon-flag'
                },
                启动: {
                    primary: 'ui-icon-play'
                },
                签收: {
                    primary: 'ui-icon-check'
                },
                保存: {
                    primary: 'ui-icon-disk'
                },
                关闭: {
                    primary: 'ui-icon-cancel'
                },
                同意: {
                    primary: 'ui-icon-check'
                },
                不同意: {
                    primary: 'ui-icon-closethick'
                },
                通知付费: {
                    primary: 'ui-icon-mail-closed'
                }
            });
        }
    };
    /*******************************************/
    /**			workflow --开始	  			  **/
    /*******************************************/

    /*******************************************/
    /**			$.common--开始	  			  **/
    /*******************************************/
    var _common_plugins = {
        // jqGrid默认参数
//        jqGrid: _plugin_jqGrid,
//        validator: _plugin_validator,
        jqui: _plugin_jqui,
//        jstree: _plugin_jstree,
        workflow: _plugin_workflow
    };

    // 插件扩展
    $.common.plugin = _common_plugins;

    //-- frame工具 --//
    $.common.frame = {
        /**
         * 让iframe自适应高度
         */
        autoSizeIframe: function(iframeId) {
            var parentHeight = $('#' + iframeId).parent();
            $('#' + iframeId).height(parentHeight);
        }
    };

    //-- 和系统有关的函数 --//
    $.common.system = {
        // 获取系统属性
        getProp: function(options) {
            var defaults = {
                url: ctx + '/common/sysprop!findProp.action',
                params: {
                    key: ''
                },
                callback: null,
                error: null
            };

            $.extend(true, defaults, options);

            $.ajax({
                url: defaults.url,
                cache: false,
                dataType: 'json',
                data: defaults.params,
                success: function(prop, textStatus) {
                    if ($.isFunction(defaults.callback)) {
                        defaults.callback(prop);
                    }
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    if ($.isFunction(defaults.error)) {
                        defaults.error(XMLHttpRequest, textStatus, errorThrown);
                    }
                }
            });
        },

        /*
         * 为下拉框加载数据字典
         */
        loadDicts: function() {
            var dictUrl = _sub_sys_url.common + '/common/system-dictionary!findTypeForOption.action'
            $('.dict-code').each(function() {
                var srcEle = this;
                $.post(dictUrl, {
                    type: $(srcEle).attr('dicttype')
                }, function(resp) {
                    $(srcEle).html(resp);
                });
            });
        }
    };

    //-- 浏览器工具 --//
    $.common.browser = {
        // 检测是否是IE浏览器
        isIE: function() {
            var _uaMatch = $.uaMatch(navigator.userAgent);
            var _browser = _uaMatch.browser;
            if (_browser == 'msie') {
                return true;
            } else {
                return false;
            }
        },
        // 检测是否是chrome浏览器
        isChrome: function() {
            var _uaMatch = $.uaMatch(navigator.userAgent);
            var _browser = _uaMatch.browser;
            if (_browser == 'webkit') {
                return true;
            } else {
                return false;
            }
        },
        // 检测是否是Firefox浏览器
        isMozila: function() {
            var _uaMatch = $.uaMatch(navigator.userAgent);
            var _browser = _uaMatch.browser;
            if (_browser == 'mozilla') {
                return true;
            } else {
                return false;
            }
        },
        // 检测是否是Firefox浏览器
        isOpera: function() {
            var _uaMatch = $.uaMatch(navigator.userAgent);
            var _browser = _uaMatch.browser;
            if (_browser == 'opera') {
                return true;
            } else {
                return false;
            }
        }
    };

    //-- 编码相关 --//
    $.common.code = {
        /**
         * 把文本转换为HTML代码
         * @param {Object} text	原始文本
         */
        htmlEncode: function(text) {
            var textold;
            do {
                textold = text;
                text = text.replace("\n", "<br>");
                text = text.replace("\n", "<br/>");
                text = text.replace("\n", "<BR/>");
                text = text.replace("\n", "<BR>");
                text = text.replace(" ", "&nbsp;");
            } while (textold != text);

            return text;
        },

        /**
         * 把HTML代码转换为文本
         * @param {Object} text	原始HTML代码
         */
        htmlDecode: function(text) {
            var textold;
            do {
                textold = text;
                text = text.replace("<br>", "\n");
                text = text.replace("<br/>", "\n");
                text = text.replace("<BR>", "\n");
                text = text.replace("<BR/>", "\n");
                text = text.replace("&nbsp;", " ");
            } while (textold != text);
            return text;
        }

    };

    //-- 数学工具 --//
    $.common.math = {
        /*
         * 四舍五入
         */
        round: function(dight, how) {
            return dight.toFixed(how);
        }
    };

    //-- 文件相关 --//
    $.common.file = {
        /**
         * 下载文件
         * @fileName	相对于Web根路径
         */
        download: function(fileName) {
            var downUrl = ctx + '/file/download.action?fileName=' + fileName;
            location.href = encodeURI(encodeURI(downUrl));
        },

        /**
         * 友好文件大小：KB、MB
         */
        friendlySize: function(size) {
            if (size < 1024 * 1024) {
                return $.common.math.round(size / 1024, 2) + "KB";
            } else {
                return $.common.math.round(size / (1024 * 1024), 2) + "MB";
            }
        }
    };

    //-- 字符工具 --//
    $.common.string = {
        /*
         * 如果对象为空返回空字符串
         */
        emptyIfNull: function(str) {
            return str ? str : '';
        }
    };

    //-- 未分类 --//
    $.common.custom = {
        // 得到应用名
        getCtx: function() {
            try {
                return ctx || '';
            } catch (e) {
                //alert('没有设置ctx变量');
            }
        },
        getLoadingImg: function() {
            return '<img src="' + $.common.custom.getCtx() + '/images/ajax/loading.gif" align="absmiddle"/>&nbsp;';
        },
        /**
         * 创建小时下拉框
         */
        createHourSelect: function(selectId, defaultValue) {
            var hours = new StringBuffer();
            var tempValue = "";
            for (var i = 0; i < 24; i++) {
                if (i < 10) {
                    tempValue = "0" + i;
                } else {
                    tempValue = i;
                }
                hours.append("<option value='" + tempValue + "'" + (defaultValue == tempValue ? " selected" : "") + ">" + tempValue + "</option>");
            }
            $(selectId).append(hours.toString());
        },
        /**
         * 创建分钟下拉框
         */
        createMinuteSelect: function(selectId, defaultValue) {
            var hours = new StringBuffer();
            var tempValue = "";
            for (var i = 0; i < 60; i++) {
                if (i < 10) {
                    tempValue = "0" + i;
                } else {
                    tempValue = i;
                }
                hours.append("<option value='" + tempValue + "'" + (defaultValue == tempValue ? " selected" : "") + ">" + tempValue + "</option>");
            }
            $(selectId).append(hours.toString());
        },

        /**
         * 日期增加年数或月数或天数
         * @param {String} BaseDate	要增加的日期
         * @param {Object} interval	增加数量
         * @param {Object} DatePart	增加哪一部分
         * @param {String} ReturnType 返回类型strunt|date
         */
        dateAdd: function(BaseDate, interval, DatePart, ReturnType) {
            var dateObj;
            if (typeof BaseDate == 'object') {
                dateObj = BaseDate;
            } else {
                var strDs = BaseDate.split('-');
                var year = parseInt(strDs[0]);
                var month = parseInt(strDs[1]);
                var date = parseInt(strDs[2]);
                dateObj = new Date(year, month, date);
            }
            ReturnType = ReturnType || 'string';
            var millisecond = 1;
            var second = millisecond * 1000;
            var minute = second * 60;
            var hour = minute * 60;
            var day = hour * 24;
            var year = day * 365;

            var newDate;
            var dVal = new Date(dateObj);
            var dVal = dVal.valueOf();
            switch (DatePart) {
                case "ms":
                    newDate = new Date(dVal + millisecond * interval);
                    break;
                case "s":
                    newDate = new Date(dVal + second * interval);
                    break;
                case "mi":
                    newDate = new Date(dVal + minute * interval);
                    break;
                case "h":
                    newDate = new Date(dVal + hour * interval);
                    break;
                case "d":
                    newDate = new Date(dVal + day * interval);
                    break;
                case "y":
                    newDate = new Date(dVal + year * interval);
                    break;
                default:
                    return escape("日期格式不对");
            }
            newDate = new Date(newDate);
            if (ReturnType == 'string') {
                return newDate.getFullYear() + "-" + newDate.getMonth() + "-" + newDate.getDate();
            } else if (ReturnType == 'date') {
                return newDate;
            }
        },

        /**
         * 把毫秒转换为自然语言
         * @param {Object} millis
         */
        timeRange: function(millis) {
            // 计算出相差天数
            var days = Math.floor(millis / (24 * 3600 * 1000));

            // 计算相差小时
            var leave1 = millis % (24 * 3600 * 1000); //计算天数后剩余的毫秒数
            var hours = Math.floor(leave1 / (3600 * 1000));

            //计算相差分钟数
            var leave2 = leave1 % (3600 * 1000); //计算小时数后剩余的毫秒数
            var minutes = Math.floor(leave2 / (60 * 1000));

            //计算相差秒数
            var leave3 = leave2 % (60 * 1000); //计算分钟数后剩余的毫秒数
            var seconds = Math.round(leave3 / 1000);

            var result = "";
            if (days > 0) {
                result += days + "天";
            }
            if (hours > 0) {
                result = result == "" ? "" : result + " ";
                result += hours + "小时";
            }
            if (minutes > 0) {
                result = result == "" ? "" : result + " ";
                result += minutes + "分钟";
            }
            if (seconds > 0) {
                result = result == "" ? "" : result + " ";
                result += seconds + "秒";
            }
            return result;
            //return "相差 " + days + "天 " + hours + "小时 " + minutes + " 分钟" + seconds + " 秒";

        }
    };

    /*******************************************/
    /**			$.form--开始  	  			  **/
    /*******************************************/
    //-- 表单自定义功能 --//
    $.form = {};

    // 绑定form的ajax提交功能
    $.form.bindAjaxSubmit = function(settings) {

        var defaults = {
            formId: '',
            beforeSubmit: showRequest,
            success: showResponse,
            clearForm: true
        };

        settings = $.extend({}, defaults, settings);

        // 重要：防止重复绑定
        if ($(settings.formId).data('binded') === true) {
            return;
        };

        $(settings.formId).data('binded', true).submit(function(e) {
            $(this).ajaxSubmit(settings);
            return false;
        });

    };

    // 表示层设置
    $.form.ui = {
        // 红色星号
        required: function() {
            return $.common.plugin.jqGrid.form.must();
        },

		// 根据属性设置
		initRequired: function(selector) {
			$('.required', selector).each(function() {
				if ($(this).parent().find('.must').length >= 1) {
					$(this).parent().find('.must').remove();
				}
				$(this).after($.common.plugin.jqGrid.form.must());
			});
		}
    };

    // -- 自定义插件 --//
    /**
     * 插件名称：cursorInsert（光标处插入） 功能：可以在文本框的
     */
    $.fn.cursorInsert = function(options) {

        // default settings
        var settings = {
            content: ''
        };

        if (options) {
            $.extend(settings, options);
        }

        return this.each(function() {
            var obj = $(this).get(0);
            if (document.selection) {
                obj.focus();
                var sel = document.selection.createRange();
                document.selection.empty();
                sel.text = options.content;
            } else {
                var prefix, main, suffix;
                prefix = obj.value.substring(0, obj.selectionStart);
                main = obj.value.substring(obj.selectionStart, obj.selectionEnd);
                suffix = obj.value.substring(obj.selectionEnd);
                obj.value = prefix + options.content + suffix;
            }
            obj.focus();
        });
    };

    /**
     * 随滚动条滚动
     */
    $.fn.autoScroll = function() {
        var _this = this;
        $(_this).css({
            position: 'absolute'
        });

        $(window).scroll(function() {
            $(_this).css({
                top: $(this).scrollTop() + $(this).height() - 500
            });
        });

    };

    /**
     * 动态加载JavaScript
     */
    $.loadScript = function(options) {
        var ga = document.createElement('script');
        ga.type = 'text/javascript';
        ga.async = true;
        ga.src = options.src;
        var s = document.getElementsByTagName('script')[0];
        s.parentNode.insertBefore(ga, s);
    };

    /*
     * 是否可以写日志
     */
    function can_log() {
        if (javascript_log_enable == false || $.common.browser.isIE()) {
            return false;
        }
        return console != undefined;
    };

    /**
     * jquery插件形式的firebug日志
     * @param {Object} msg
     */
    $.fn.log = function(msg) {
        if (!can_log()) {
            return this;
        }
        console.log("%s: %o", msg, this);
        return this;
    };

    $.log = $.log || {};
    /**
     * firebug日志
     * @param {Object} msg
     */
    $.extend($.log, {
        log: function(msg) {
            if (!can_log()) {
                return;
            }
            console.log(msg);
        },
        debug: function(msg) {
            if (!can_log()) {
                return;
            }
            console.debug(msg);
        },
        info: function(msg) {
            if (!can_log()) {
                return;
            }
            console.info(msg);
        },
        warn: function(msg) {
            if (!can_log()) {
                return;
            }
            console.warn(msg);
        },
        error: function(msg) {
            if (!can_log()) {
                return;
            }
            console.error(msg);
        }
    });

    /**
     * 获取元素的outerHTML
     */
    $.fn.outerHTML = function() {

        // IE, Chrome & Safari will comply with the non-standard outerHTML, all others (FF) will have a fall-back for cloning
        return (!this.length) ? this : (this[0].outerHTML ||
        (function(el) {
            var div = document.createElement('div');
            div.appendChild(el.cloneNode(true));
            var contents = div.innerHTML;
            div = null;
            return contents;
        })(this[0]));

    };

})(jQuery);

//-- 自定义函数 --//
function _initFunction() {
    $.extend({
        jsonToString: function(object) {
            if (object == null) {
                return 'null';
            }
            var type = typeof object;
            if ('object' == type) {
                if (Array == object.constructor) {
                    type = 'array';
                } else if (RegExp == object.constructor) {
                    type = 'regexp';
                } else {
                    type = 'object';
                }
            }
            switch (type) {
                case 'undefined':
                case 'unknown':{
                    return;
                    break;
                }
                case 'function':{
                    return '"' + object() + '"';
                    break;
                }
                case 'boolean':
                case 'regexp':{
                    return object.toString();
                    break;
                }
                case 'number':{
                    return isFinite(object) ? object.toString() : 'null';
                    break;
                }
                case 'string':{
                    return '"' +
                    object.replace(/(\\|\")/g, "\\$1").replace(/\n|\r|\t/g, function() {
                        var a = arguments[0];
                        return (a == '\n') ? '\\n' : (a == '\r') ? '\\r' : (a == '\t') ? '\\t' : ""
                    }) +
                    '"';
                    break;
                }
                case 'object':{
                    if (object === null)
                        return 'null';
                    var results = [];
                    for (var property in object) {
                        var value = jquery.jsonToString(object[property]);
                        if (value !== undefined)
                            results.push(jquery.jsonToString(property) + ':' + value);
                    }
                    return '{' + results.join(',') + '}';
                    break;

                }
                case 'array':{
                    var results = [];
                    for (var i = 0; i < object.length; i++) {
                        var value = jquery.jsonToString(object[i]);
                        if (value !== undefined)
                            results.push(value);
                    }
                    return '[' + results.join(',') + ']';
                    break;

                }
            }
        }
    });

    // 全局ajax设置
    $.ajaxSetup({
        cache: false,
        global: true,
        jsonp: null,
        jsonpCallback: null,
        complete: function(req, status) {
            if (!req.responseText) {
                return;
            }
            if (req.responseText == '_login_timeout' || req.responseText.indexOf('登录页') != -1) {
                // 打开重新登录窗口
                if ($.isFunction($.common.window.getTopWin().relogin)) {
                    $.common.window.getTopWin().relogin();
                } else {
                    alert('登录已超时，请保存数据后重新登录！');
                }
            }
        },
        error: function(req, status) {
            var reqText = req.responseText;
            if (reqText == 'login') {
                return;
            }
            if (reqText == 'error') {
                alert('提示：操作失败！');
            } else if (reqText != '') {
                alert("提示：" + reqText);
            }
        }
    });

    // jqgrid
    if ($.jgrid) {
        $.jgrid.no_legacy_api = true;
        $.jgrid.useJSON = true;
        $.jgrid.ajaxOptions.type = 'post';
    }

    // blockui support linux FF
    if ($.blockUI) {
        var userAgent = $.uaMatch(navigator.userAgent);
        if (userAgent.browser == 'mozilla' && navigator.userAgent.indexOf('Linux') != -1) {
            // enable transparent overlay on FF/Linux
            $.blockUI.defaults.applyPlatformOpacityRules = false;
        }
    }

    // jquery validator
    if ($.validator) {
    	// 银行卡号
        $.validator.addMethod("bankcard", function(value, element, params) {
            var regPex = /(^\d{16}|^\d{17}|^\d{18}|^\d{19}|^\d{20})$/;
            return this.optional(element) || regPex.exec(value);
        }, jQuery.format("请输入合法的银行卡号(长度：16~20)"));

        // 不能大于当天
        $.validator.addMethod("canNotMoreThanToday", function(value, element, params) {
        	var values = value.split('-');
            return this.optional(element) || new Date(values[0], values[1], values[2]).getMilliseconds() <= new Date().getMilliseconds();
        }, jQuery.format("日期不能大于今天！"));
    }
};

//-- Javascript对象扩展--开始-//
/**
 * 去掉开头、结尾的空格
 *
 * @return {}
 */
String.prototype.trim = function() {
    return this.replace(/(^\s+)|\s+$/g, "");
};

/**
 * 转换字符串为json对象
 */
String.prototype.toJson = function() {
    return eval('(' + this + ')');
};

String.prototype.endsWithIgnoreCase = function(str) {
    return (this.toUpperCase().match(str.toUpperCase() + "$") == str.toUpperCase()) ||
    (this.toLowerCase().match(str.toLowerCase() + "$") == str.toLowerCase());
}

/**
 * 输出2010-02-05格式的日期字符串
 *
 * @return {}
 */
Date.prototype.toDateStr = function() {
    return ($.common.browser.isMozila() || $.common.browser.isChrome() ? (this.getYear() + 1900) : this.getYear()) + "-" +
    (this.getMonth() < 10 ? "0" + this.getMonth() : this.getMonth()) +
    "-" +
    (this.getDate() < 10 ? "0" + this.getDate() : this.getDate());
};

/**
 * 日期格式化
 * @param {Object} format
 */
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


/**
 * 将字符串格式的日期转换为日期类型对象
 * @param {Object} strDate
 */
Date.toDate = function(strDate) {
    var strDs = strDate.split('-');
    var year = parseInt(strDs[0]);
    var month = parseInt(strDs[1]);
    var date = parseInt(strDs[2]);
    return new Date(year, month, date);
};

/**
 * 通过当前时间计算当前周数
 */
Date.prototype.getWeekNumber = function() {
    var d = new Date(this.getFullYear(), this.getMonth(), this.getDate(), 0, 0, 0);
    var DoW = d.getDay();
    d.setDate(d.getDate() - (DoW + 6) % 7 + 3); // Nearest Thu
    var ms = d.valueOf(); // GMT
    d.setMonth(0);
    d.setDate(4); // Thu in Week 1
    return Math.round((ms - d.valueOf()) / (7 * 864e5)) + 1;
}


//+---------------------------------------------------
//| 日期计算
//+---------------------------------------------------
Date.prototype.DateAdd = function(strInterval, Number) {
    var dtTmp = this;
    switch (strInterval) {
        case 's':
            return new Date(Date.parse(dtTmp) + (1000 * Number));
        case 'n':
            return new Date(Date.parse(dtTmp) + (60000 * Number));
        case 'h':
            return new Date(Date.parse(dtTmp) + (3600000 * Number));
        case 'd':
            return new Date(Date.parse(dtTmp) + (86400000 * Number));
        case 'w':
            return new Date(Date.parse(dtTmp) + ((86400000 * 7) * Number));
        case 'q':
            return new Date(dtTmp.getFullYear(), (dtTmp.getMonth()) + Number * 3, dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());
        case 'm':
            return new Date(dtTmp.getFullYear(), (dtTmp.getMonth()) + Number, dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());
        case 'y':
            return new Date((dtTmp.getFullYear() + Number), dtTmp.getMonth(), dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());
    }
};

//-- Javascript对象扩展--结束 -//

//-- 自定义类-开始 --/
function StringBuffer() {
    this._strings_ = new Array();
}

StringBuffer.prototype.append = function(str) {
    this._strings_.push(str);
    return this;
};

StringBuffer.prototype.toString = function() {
    return this._strings_.join("").trim();
};

/**
 * 以键值对存储
 */
function Map() {
    var struct = function(key, value) {
        this.key = key;
        this.value = value;
    };

    var put = function(key, value) {
        for (var i = 0; i < this.arr.length; i++) {
            if (this.arr[i].key === key) {
                this.arr[i].value = value;
                return;
            }
        }
        this.arr[this.arr.length] = new struct(key, value);
        this._keys[this._keys.length] = key;
    };

    var get = function(key) {
        for (var i = 0; i < this.arr.length; i++) {
            if (this.arr[i].key === key) {
                return this.arr[i].value;
            }
        }
        return null;
    };

    var remove = function(key) {
        var v;
        for (var i = 0; i < this.arr.length; i++) {
            v = this.arr.pop();
            if (v.key === key) {
                continue;
            }
            this.arr.unshift(v);
            this._keys.unshift(v);
        }
    };

    var size = function() {
        return this.arr.length;
    };

    var keys = function() {
        return this._keys;
    };

    var isEmpty = function() {
        return this.arr.length <= 0;
    };

    this.arr = new Array();
    this._keys = new Array();
    this.keys = keys;
    this.get = get;
    this.put = put;
    this.remove = remove;
    this.size = size;
    this.isEmpty = isEmpty;
}

/**
 * 更新jquery ui css
 * @param {Object} locStr
 */
function updateCSS(locStr) {
    var cssLink = $('<link href="' + locStr + '" type="text/css" rel="Stylesheet" class="ui-theme" />');
    $("head").append(cssLink);
    if ($("link.ui-theme").size() > 3) {
        $("link.ui-theme:first").remove();
    }
}

/**
 * 更新自定义CSS
 */
function updateCustomCss() {
    var customStyleUrl = ctx + '/css/style.css';
    var cssLink = $('<link href="' + customStyleUrl + '" type="text/css" rel="Stylesheet" class="custom-style" />');
    $("head").append(cssLink);
    if ($("link.custom-style").size() > 3) {
        $("link.custom-style:first").remove();
    }
}

/**
 * 引入css、script文件
 * @param {Object} file
 */
function include(file) {
    var files = typeof file == "string" ? [file] : file;
    for (var i = 0; i < files.length; i++) {
        var name = files[i].replace(/^\s|\s$/g, "");
        var att = name.split('.');
        var ext = att[att.length - 1].toLowerCase();
        var isCSS = ext == "css";
        var tag = isCSS ? "link" : "script";
        var attr = isCSS ? " type='text/css' rel='stylesheet' " : " language='javascript' type='text/javascript' ";
        var link = (isCSS ? "href" : "src") + "='" + '' + name + "'";
        if ($(tag + "[" + link + "]").length == 0) {
            $("<" + tag + attr + link + "></" + tag + ">").appendTo('head');
        }
    }
}

//-- 自定义类-结束 --/
