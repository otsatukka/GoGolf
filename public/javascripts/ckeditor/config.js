/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/
CKEDITOR.on( 'dialogDefinition', function( ev ) {
    // Take the dialog name and its definition from the event data
    var dialogName = ev.data.name;
    var dialogDefinition = ev.data.definition;

    if ( dialogName == 'image' ) {
        // Remove upload tab
        dialogDefinition.removeContents('Advanced');
    }
});

CKEDITOR.editorConfig = function( config )
{
  config.PreserveSessionOnFileBrowser = true;
  // Define changes to default configuration here. For example:
  config.language = 'fi';
  config.defaultLanguage = 'fi';
  config.uiColor = '#AADC6E';

  //config.ContextMenu = ['Generic','Anchor','Flash','Select','Textarea','Checkbox','Radio','TextField','HiddenField','ImageButton','Button','BulletedList','NumberedList','Table','Form'] ; 
  
  config.height = '1000px';
  config.width = '750px';
  
  config.resize_enabled = false;
  //config.resize_maxHeight = 2000;
  //config.resize_maxWidth = 750;
  
  //config.startupFocus = true;
  
  // works only with en, ru, uk languages
  config.extraPlugins = "embed,attachment";
  
  config.toolbar = 'Post';
  
  config.toolbar_Easy =
    [
        ['Source','-','Preview','Templates'],
        ['Cut','Copy','Paste','PasteText','PasteFromWord',],
        ['Maximize','-','About'],
        ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
        ['Styles','Format'],
        ['Bold','Italic','Underline','Strike','-','Subscript','Superscript', 'TextColor'],
        ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
        ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
        ['Link','Unlink','Anchor'],
        ['Image','Embed','Flash','Attachment','Table','HorizontalRule','Smiley','SpecialChar','PageBreak']
    ];
    
    config.toolbar_Author =
      [
          ['Cut','Copy','Paste'],
          ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
          ['Bold','Italic'],
          ['NumberedList','BulletedList'],
          ['Link','Unlink','Anchor'],
          ['Image','Embed']
      ];
    config.toolbar_Basic =
      [
          ['Cut','Copy','Paste'],
          ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
          ['Bold','Italic'],
          ['NumberedList','BulletedList'],
          ['Link','Unlink','Anchor'],
          ['Embed']
      ];
};

