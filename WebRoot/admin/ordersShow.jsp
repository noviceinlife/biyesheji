<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品订单信息</title>
<link href="css/main.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script language="javascript" type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
var tempClassName="";
function tr_mouseover(obj) 
{ 
	tempClassName=obj.className;
	obj.className="list_mouseover";
}
function tr_mouseout(obj)      
{ 
	obj.className=tempClassName;
}      
function CheckAll(obj) 
{
	var checks=document.getElementsByName("chkid");
    for (var i=0;i<checks.length;i++)
	{
	    var e = checks[i];
	    e.checked = obj.checked;
	}
    
}


function serch()
{
   document.info.action="Admin_listOrderss.action";
   document.info.submit();
}
function del()
{
	var checks=document.getElementsByName("chkid");
    var ids="";
	for (var i=0;i<checks.length;i++)
    {
        var e = checks[i];
		if(e.checked==true)
		{
		  if(ids=="")
		  {
		    ids=ids+e.value;
		  }
		  else
		  {
		    ids=ids+","+e.value;
		  }
		}
    }
    if(ids=="")
    {
       alert("请至少选择一个要删除的商品订单！");
       return false;
    }
    if(confirm('确认删除吗!?'))
    {
       document.info.action="Admin_delOrderss.action?ids="+ids;
       document.info.submit();
    }
    
}
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
  document.info.action="Admin_listOrderss.action";
  document.info.submit();
}
function ChangePage(pagenum)
{
  document.getElementById("pageNo").value=pagenum;
  document.info.action="Admin_listOrderss.action";
  document.info.submit();
}
</script>
</head>
<body>
<div class="pageTitle">
	&nbsp;&nbsp;<img src="images/right1.gif" align="middle" /> &nbsp;<span id="MainTitle" style="color:white">商品订单管理&gt;&gt;商品订单查询</span>
</div>
<form name="info" id="info" action="Admin_listOrderss.action" method="post">
<input type="hidden" name="pageNo" id="pageNo" value="${paperUtil.pageNo}"/>
<table width="95%" align="center" cellpadding="0" cellspacing="0">
  <tr><td colspan="2" height="10px">&nbsp;</td></tr>
  <tr>
    <td width="">商品订单列表</td>
    <td width="" align="right">
            订单编号：
      <input type="text" id="paramsOrders.orders_no" name="orders_no" value="${paramsOrders.orders_no}" class="inputstyle" Style="width:100px;"/>&nbsp;      
            用户姓名：
      <input type="text" id="paramsOrders.real_name" name="real_name" value="${paramsOrders.real_name}" class="inputstyle" Style="width:100px;"/>&nbsp;
            订单状态：
      <select name="orders_flag" id="orders_flag" class="selectstyle" style="width:100px">
      	  <option value="0">请选择</option> 
	      <option ${1==paramsGoods.orders_flag?'selected':''} value="1">待发货</option> 
	      <option ${2==paramsGoods.orders_flag?'selected':''} value="2">已发货</option> 
	      <option ${3==paramsGoods.orders_flag?'selected':''} value="3">已收货</option> 
	  </select>&nbsp;
      <input type="button" value="搜索" onclick="serch();" class="btnstyle"/>&nbsp;
      <c:if test="${admin.user_type==2}">
      <input type="button" value="删除" onclick="del();" class="btnstyle"/>
      </c:if>
    </td>
  </tr>
  <tr><td colspan="2" height="2px"></td></tr>  
</table>
<table width="95%" align="center" class="table_list" cellpadding="0" cellspacing="0">
   <tr class="listtitle">
    <c:if test="${admin.user_type==2}">
     <td width="40" align="center"><input type="checkbox" onclick="CheckAll(this);" style="vertical-align:text-bottom;" title="全选/取消全选"/></td>
     </c:if>		    
     <td width="40" align="center">序号</td>
     <td width="" align="center">订单编号</td>
     <td width="" align="center">商品名称</td>
     <td width="" align="center">商品价格</td>
     <td width="" align="center">用户姓名</td>
     <td width="" align="center">订单日期</td>
     <td width="" align="center">收货地址</td>
     <td width="" align="center">联系电话</td>
     <td width="" align="center">当前状态</td>
     <td width="" align="center">操作</td>
   </tr>
   <c:if test="${orderss!=null &&  fn:length(orderss)>0}">
   <c:forEach items="${orderss}" var="orders" varStatus="status">
   <tr class="list0" onmouseover="tr_mouseover(this)" onmouseout="tr_mouseout(this)"> 
     <c:if test="${admin.user_type==2}">
     <td width="" align="center"><input type="checkbox" name="chkid" value="${orders.orders_id}" style="vertical-align:text-bottom;"/></td>
     </c:if>
     <td width="" align="center">${status.index+1}</td>
     <td width="" align="center">${orders.orders_no}</td>
     <td width="" align="center">${orders.goods_name}</td>
     <td width="" align="center">${orders.goods_price}</td>
     <td width="" align="center">${orders.real_name}</td>
     <td width="" align="center">${fn:substring(orders.orders_date,0,10)}</td>
     <td width="" align="center">${orders.user_address}</td>
     <td width="" align="center">${orders.user_phone}</td> 
     <td width="" align="center">${orders.orders_flagDesc}</td>
     <td width="" align="center">&nbsp;
       <c:if test="${orders.orders_flag==1 && admin.user_type==2 }">
       <a href="Admin_sendOrders.action?orders_id=${orders.orders_id}">发货</a>&nbsp;&nbsp;
       </c:if>
       <c:if test="${orders.orders_flag!=1}">
       <a href="Admin_listLogisticss.action?orders_no=${orders.orders_no}">物流信息</a>&nbsp;&nbsp;
       </c:if>
     </td>
   </tr> 
   </c:forEach>
   </c:if>
   <c:if test="${orderss==null || fn:length(orderss)==0}">
   <tr>
     <td height="60" colspan="12" align="center"><b>&lt;不存在商品订单信息&gt;</b></td>
   </tr>
   </c:if>
   
</table>
<jsp:include page="page.jsp"></jsp:include>
</form> 
</body>
</html>