<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>修改个人信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/store.css">
<script language="javascript" type="text/javascript" src=""></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script language="javascript" type="text/javascript"> 
	var user_id="${userFront.user_id}";
	if(user_id==null || user_id==''){
		alert("请先登录！");
		window.location.href="page_index.action";
	}
</script>
<style type="text/css">
 body,td,div
 {
   font-size:12px;
 }
</style>
</head>
<body>
<jsp:include page="top.jsp"></jsp:include>
<div id="middle">
	 <jsp:include page="leftMenu.jsp"></jsp:include>
	 <!--  购物车 -->
	 <div id="product_info">
			<div class="title">修改个人信息</div>
			<div style="margin-top:5px">
				 <form id="infoSelf" name="infoSelf" action="page_saveUserFront.action" method="post">    
				 <input type="hidden" name="user_id" value="${userFront.user_id}"/>
				 <table class="ptable" style="margin-bottom:5px;">
					<tr>
			          <td width="15%" align="right" style="padding-right:5px">用户名：</td>
			          <td colspan="3">${userFront.user_name}</td>
			        </tr> 
			        <tr>
			          <td width="15%" align="right" style="padding-right:5px"><font color="red">*</font> 姓名：</td>
			          <td width="35%">
			            <input type="text" id="real_name" name="real_name" value="${userFront.real_name}"/>
			          </td> 
			          <td width="15%" align="right" style="padding-right:5px"><font color="red">*</font> 昵称：</td>
			          <td width="35%">
			            <input type="text" id="nick_name" name="nick_name" value="${userFront.nick_name}"/>
			          </td>
			        </tr>
			        <tr>
			          <td align="right" style="padding-right:5px">邮箱：</td>
			          <td>
			             <input type="text" id="user_mail" name="user_mail" value="${userFront.user_mail}"/>
			          </td>
			          <td align="right" style="padding-right:5px">电话：</td>
			          <td>
			             <input type="text" id="user_phone" name="user_phone" value="${userFront.user_phone}"/>
			          </td>
			        </tr> 
			        <tr class="">
			          <td align="center" height="30" colspan="4">
			            <input type="button" id="saveBtn" Class="btnstyle" value="修 改"/>&nbsp;
			            <span style="color:red">${tip }</span>
			          </td>
			        </tr>
				 </table>
				 </form>
			</div>
		</div>
	 <!--  购物车 -->
</div>
<jsp:include page="bottom.jsp"></jsp:include>
<script language="javascript" type="text/javascript">
	$(document).ready(function(){
		 var num=/^\d+$/;
		 $("#saveBtn").bind('click',function(){
			if($("#real_name").val()==''){
				alert('姓名不能为空');
				return;
			}
			if($("#nick_name").val()==''){
				alert('昵称不能为空');
				return;
			}
			var aQuery = $("#infoSelf").serialize();  
			$.post('page_saveUserFront.action',aQuery,
				function(responseObj) {
						if(responseObj.success) {	
							 alert('修改成功！');
						}else  if(responseObj.err.msg){
							 alert('失败：'+responseObj.err.msg);
						}else{
							 alert('失败：服务器异常！');
						}	
			 },'json');
			 
		 });
		
	});	 
</script>
</body>
</html>