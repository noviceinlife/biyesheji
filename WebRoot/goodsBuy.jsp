<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>商品求购页面</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/style.css" />
<link rel="stylesheet" type="text/css" href="css/main.css" />
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script language="javascript" type="text/javascript"> 
$(document).ready(function(){
	$("#buyTopBtn").bind("click",function(){
 		var user_id = "${userFront.user_id}";
 		if(user_id==''){
 			alert("请先登录！");
 			return;
 		}
 		window.open("page_listMyGoodsBuys.action", "商品求购")
 	});
	
	//搜索
 	$("#big_searchBtn").bind("click",function(){
 		$("#info").attr("action","page_goodsBuy.action").removeAttr("target").submit();
 	});
	
	//头像
 	var addReplyPics = ['avatar1.png','avatar2.png','avatar3.png','avatar4.png','avatar5.png'];
   	function getReplyPic(){
   		var picIndex = Math.floor(Math.random()*5);
   		return addReplyPics[picIndex];
   	}	
	
	//显示评论
 	$("input[id^='replyBuy']").bind("click",function(){
 		var goods_id = $(this).attr("id").split("_")[1]
		$("#replyBuy_con_"+goods_id).toggle();
	});
	
	//评论
 	var user_id="${userFront.user_id}";
   	$("input[id^='addReply']").bind("click",function(){
   		var goods_id = $(this).attr("id").split("_")[1];
		var sblog_pic = $("#sblog_pic_"+goods_id);
		var sblog_content = $("#sblog_content_"+goods_id);
		
		if(user_id==''){
			alert("请先登录");
			return;
		}
		if(sblog_content.val()==''){
			alert("评论内容不能为空");
			return;
		}
		 
		var aQuery = {
				'goods_id':goods_id,
				'user_id':user_id,
				'sblog_pic':sblog_pic.val(),
				'sblog_content':sblog_content.val()
		}//;$("#infoReply").serialize();  
		$.post('page_addSblog.action',aQuery,
			function(responseObj) {
					if(responseObj.success) {	
						 $("#replyTitle_"+goods_id).after(
								 '<div class="replyCon">'+
								 '<div class="replyCon1"><img src="images/'+sblog_pic.val()+'" /></div>'+
								 '<div class="replyCon2">'+
										'<span style="color:#00947e;">${userFront.nick_name}</span> '+ 
										'<span style="color:#666;">'+calender()+'</span>'+ 
										'<br/>'+sblog_content.val()+
								  '</div>'+
								  '</div>'
						 );
						 sblog_pic.val(getReplyPic());
						 $("#addReplyPic_"+goods_id).attr("src","images/"+sblog_pic.val());
						 sblog_content.val("");
						 
						 var replyBuy = $("#replyBuy_"+goods_id);
						 var replyBuyValue = replyBuy.val();
						 var replyBuyCount = replyBuyValue.substring(replyBuyValue.indexOf("(")+1,replyBuyValue.length-1);
						 replyBuy.val("评论("+(Number(replyBuyCount)+1)+")");
						 
					}else  if(responseObj.err.msg){
						 alert('失败：'+responseObj.err.msg);
					}else{
						 alert('失败：服务器异常！');
					}	
		 },'json');
	});
});  
	
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
 
<div id="mainArea">
	<div class="mainArea2">
		<div class="buyTop">			
			 <input type="button"  id="buyTopBtn" value="发布求购" class="btnstyle"/>
		</div>	 
	</div>
	
	<c:if test="${goodss!=null &&  fn:length(goodss)>0}">
   	<c:forEach items="${goodss}" var="goods" varStatus="status">
	<div class="mainArea2" style="background-color: white;margin-left:5px;margin-top:5px;width:985px">
		<div id="headShow">
			  <img src="images/avatar${goods.goods_head}.png" />
		</div>	
		<div id="contentShow">
			<span style="color:#00947e;font-weight:bold;font-size:14px;">[求购] ${goods.goods_name }</span>
			<br/><s:property value='#goods.goods_desc' escape="false"/>
			<br/>期望价格	¥${goods.goods_price }&nbsp;&nbsp;&nbsp;&nbsp;
					   交易地点：${goods.goods_address }&nbsp;&nbsp;&nbsp;&nbsp;${fn:substring(goods.goods_date,0,19) }
			<br/>联系电话：${goods.user_phone}&nbsp;&nbsp;&nbsp;&nbsp;QQ：${goods.user_qq}
			<input type="button" id="replyBuy_${goods.goods_id}" value="评论(${sblogs!=null ? fn:length(sblogs) : 0})" class="btnstyle" style="height:35px;width:100px;font-size:14px;float:right"/>
		</div>	 
	</div>


	<div class="mainArea2" id="replyBuy_con_${goods.goods_id}" style="display:none">
		<input type="hidden" id="sblog_pic_${goods.goods_id}"  value="avatar1.png"/>
		<div class="replyTitle" id="replyTitle_${goods.goods_id}">
			<input type="button"  value="用户评论" class="btnstyle" style="height:40px;width:120px;font-size:16px"/>
		</div> 
		<c:if test="${sblogs!=null &&  fn:length(sblogs)>0}">
   		<c:forEach items="${sblogs}" var="sblog" varStatus="status">
		<div class="replyCon">
			  <div class="replyCon1"><img src="images/${sblog.sblog_pic}" /></div>	
			  <div class="replyCon2">
					<span style="color:#00947e;">${sblog.nick_name}</span>
					<span style="color:#666;">${fn:substring(sblog.sblog_date,0,19) }</span> 
					<br/>${sblog.sblog_content}
			  </div>	
		</div>	
		</c:forEach>
		</c:if>
		<div class="replyCon">
			  <div class="replyCon1"><img id="addReplyPic_${goods.goods_id}" src="images/avatar1.png" /></div>	
			  <div class="replyCon3">
					 <input type="text" id="sblog_content_${goods.goods_id}"  class="inputstyle" style="width:550px;height:45px;"/>
					 <input type="button" id="addReply_${goods.goods_id}" value="评 论" class="btnstyle" style="width:55px;height:50px;font-weight:bold"/>
			  </div>	
		</div>

	</div>
	</c:forEach>
	</c:if>
	     	
	<!--  商品分页 -->
   <jsp:include page="page.jsp"></jsp:include>
	<!--  商品分页 -->

</div>
 
 
<jsp:include page="bottom.jsp"></jsp:include>
<script language="javascript" type="text/javascript">
	function GoPage()
	{
	  var pagenum=document.getElementById("goPage").value;
	  var patten=/^\d+$/;
	  if(!patten.exec(pagenum))
	  {
	    alert("页码必须为大于0的数字");
	    return false;
	  }
	  document.getElementById("pageNo").value=pagenum;
	  document.info.action="page_goodsBuy.action";
	  document.info.target="_self";
	  document.info.submit();
	}
	function ChangePage(pagenum)
	{
		 document.getElementById("pageNo").value=pagenum;
		 document.info.action="page_goodsBuy.action";
		 document.info.target="_self";
		 document.info.submit();
	}
</script>
</body>
</html>