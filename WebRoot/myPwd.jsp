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
	 <div id="product_info" style="width:746px">
			<div class="title">个人中心  &gt;&gt;  修改登录密码</div>
			<div style="margin-top:5px">
				 <form id="infoSelf" name="infoSelf" action="page_saveUserFrontPass.action" method="post">    
				 <input type="hidden" name="user_id" value="${userFront.user_id}"/>
				 <table class="ptable" style="margin-bottom:5px;">
			        <tr>
			          <td align="right" style="padding-right:5px"><font color="red">*</font> 输入新密码：</td>
			          <td colspan="3">
			            <input type="password" id="user_passA" name="user_pass"  />
			          </td>
			        </tr>
			        <tr>
			          <td align="right" style="padding-right:5px"><font color="red">*</font> 确认新密码：</td>
			          <td colspan="3">
			            <input type="password" id="user_rpassA" name="user_rpass"  />
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
	 
	 $("#saveBtn").bind('click',function(){
		if($("#user_passA").val()=='' || $("#user_rpassA").val()==''){
			alert('新密码和确认密码不能为空');
			return;
		}
		if($("#user_passA").val() != $("#user_rpassA").val()){
			alert('两次输入密码不一致');
			return;
		}
		var aQuery = $("#infoSelf").serialize();  
		$.post('page_saveUserFrontPass.action',aQuery,
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