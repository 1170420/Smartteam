/**
 * 
 */
     var Dialog = {
    	 msg:function(text){
    		 new BootstrapDialog({
       		      title   :'提示信息',
       		      message :text,
       		      draggable : true,//可拖拽
       		      type    : BootstrapDialog.TYPE_WARNING,
       		      size    : BootstrapDialog.SIZE_SMALL, //窗口大小
       		 }).open();
    	 },
    	 confirm:function(text,cellback){
    		 new BootstrapDialog({
   		      title      :'提示信息',
   		      message    :text,
   		      btnOKClass : 'btn-warning',
   		      draggable  : true,//可拖拽
   		      closable   : false,   //点击对话框以外的页面内容可关闭
   		      type       : BootstrapDialog.TYPE_SUCCESS,
   		      size       : BootstrapDialog.SIZE_SMALL,
   		      buttons :[
   		         {
   		        	 label  :'取消',
   		        	 action : function(dialog){
   		        		 dialog.close();
   		        	 }
   		         },
   		         {
   		        	label  :'确定',
   		        	 action : function(dialog){
   		        		cellback();
   		        		dialog.close();
   		        	 }
   		         },
   		     ]
   		  }).open();
        },
        
        confirm1:function(text,cellback){
   		 new BootstrapDialog({
  		      title      :'提示信息',
  		      message    :text,
  		      btnOKClass : 'btn-warning',
  		      draggable  : true,//可拖拽
  		      closable   : false,   //点击对话框以外的页面内容可关闭
  		      type       : BootstrapDialog.TYPE_WARNING,
  		      size       : BootstrapDialog.SIZE_SMALL,
  		      buttons :[
  		         {
  		        	 label  :'取消',
  		        	 action : function(dialog){
  		        		 dialog.close();
  		        	 }
  		         },
  		         {
  		        	 label  :'确定',
  		        	btnOKClass : 'btn-warning',
  		        	 action : function(dialog){
  		        		cellback();
  		        		dialog.close();
  		        	 }
  		         },
  		     ]
  		  }).open();
       }
        
     }