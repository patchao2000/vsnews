/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */


CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';

    config.toolbarGroups = [
        { name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
        { name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },

        //  remove:
//        { name: 'links' },
//        { name: 'insert' },
//        { name: 'forms' },
//        { name: 'tools' },
        { name: 'document',	   groups: [ 'mode', 'document', 'doctools' ] },
//        { name: 'others' },
//        '/',
        //  end remove

        { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
        { name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ] },
        { name: 'styles' },
        { name: 'colors' }
//        { name: 'about' }
    ];

    config.removeButtons = 'Underline,Subscript,Superscript';

    config.format_tags = 'p;h1;h2;h3;pre';

    config.removeDialogTabs = 'image:advanced;link:advanced';

    config.font_names='宋体/SimSun;黑体/SimHei;仿宋/FangSong;楷体/KaiTi;'+ config.font_names;

    config.removePlugins = 'elementspath';

    config.allowedContent = true;
//    config.resize_enabled = false;
};
