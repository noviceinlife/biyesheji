<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的购买订单</title>
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
	 <div id="product_info">
			<div class="title">个人中心  &gt;&gt;  我的购买订单</div>
			<div style="margin-top:5px">
				 <table class="ptable" style="margin-bottom:5px;">
					<tr class="head_text">
					     <td width="" align="center">订单编号</td>
					     <td width="" align="center">商品名称</td>
     					 <td width="" align="center">商品价格</td>
					     <td width="" align="center">订单日期</td>
					     <td width="" align="center">联系电话</td>
					     <td width="" align="center">收货地址</td>
					     <td width="" align="center">当前状态</td>
					     <td width="" align="center">操作</td>
					</tr>
					<c:if test="${orderss!=null &&  fn:length(orderss)>0}">
   					<c:forEach items="${orderss}" var="orders" varStatus="status">
					   <tr> 
					   	 <td width="" align="center">${orders.orders_no}</td>
					     <td width="" align="center">${orders.goods_name}</td>
					     <td width="" align="center">${orders.goods_price}</td>
					     <td width="" align="center">${fn:substring(orders.orders_date,0,10)}</td>
					     <td width="" align="center">${orders.user_phone}</td> 
					     <td width="" align="center">${orders.user_address}</td>
					     <td width="" align="center">${orders.orders_flagDesc}</td>
					     <td width="" align="center" style="line-height:22px">
					     	<c:if test="${orders.orders_flag==2}">
					     	<a id="finishOrders_${orders.orders_no}" href="javascript:void(0)">确认收货</a>&nbsp;
					     	</c:if>
					     	<c:if test="${orders.orders_flag!=1}">
					     	<br/><a href="page_listLogisticss.action?orders_no=${orders.orders_no}">物流信息</a>
					     	</c:if>
					     	&nbsp;
					     </td>
					   </tr> 
					   </c:forEach>
					</c:if>
				    <c:if test="${orderss==null || fn:length(orderss)==0}">
				    <tr>
				      <td height="60" colspan="8" align="center"><b>&lt;不存在订单信息&gt;</b></td>
				    </tr>
				    </c:if>
				 </table>
			</div>
			<div class="pages">
				<jsp:include page="page.jsp"></jsp:include>
			</div>
		</div>
	 <!--  购物车 -->
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
	  window.location.href="page_listMyOrderss2.action?pageNo="+pagenum;
	}
	function ChangePage(pagenum)
	{
		window.location.href="page_listMyOrderss2.action?pageNo="+pagenum;
	}
	
	$(document).ready(function(){
		$("a[id^='finishOrders']").bind('click',function(){
		    if(confirm('确认收货吗!?'))
		    {
		    	var orders_no=$(this).attr('id').split('_')[1];
		    	var aQuery = {
						'orders_no':orders_no
				};  
				$.post('page_finishOrders.action',aQuery,
					function(responseObj) {
							if(responseObj.success) {	
								 alert('确认收货成功！');
								 window.location.reload();
							}else  if(responseObj.err.msg){
								 alert('确认收货失败：'+responseObj.err.msg);
							}else{
								 alert('确认收货失败：服务器异常！');
							}	
				},'json');
		    }
		 });
		
	});
	 
</script>
</body>
</html>