<%@page import="com.Item"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
if (request.getParameter("itemCode") != null) {

	String stsMsg = "";
	Item itemObj = new Item();

	// check whether hidden value field is empty

	if (!request.getParameter("myId").isEmpty()) {

		stsMsg = itemObj.updateItem(request.getParameter("myId"), request.getParameter("itemCode"),
		request.getParameter("itemName"), Double.parseDouble(request.getParameter("itemPrice")),
		request.getParameter("itemDesc"));

	} else {

		stsMsg = itemObj.insertItem(request.getParameter("itemCode"), request.getParameter("itemName"),
		request.getParameter("itemPrice"), request.getParameter("itemDesc"));

	}

	session.setAttribute("statusMsg", stsMsg);

}

// check whether remove button is clicked

if (request.getParameter("itemID") != null) {

	Item itemObj = new Item();

	String itemid = request.getParameter("itemID");
	String stsMsg = itemObj.removeItems(Integer.parseInt(itemid));

	session.setAttribute("removeStatus", stsMsg);

}

// check whether update button is clicked

if (request.getParameter("updateID") != null) {

	String id = request.getParameter("updateID");

	Item itemObj = new Item();
	Item resitem = itemObj.readOneItem(id);

	session.setAttribute("itemID", resitem.getItemId());
	session.setAttribute("itemCode", resitem.getItemCode());
	session.setAttribute("itemName", resitem.getItemName());
	session.setAttribute("itemPrice", resitem.getItemPrice());
	session.setAttribute("itemDes", resitem.getItemDesc());

	System.out.println(resitem.toString());

} else {

	session.setAttribute("itemID", "");
	session.setAttribute("itemCode", "");
	session.setAttribute("itemName", "");
	session.setAttribute("itemPrice", "");
	session.setAttribute("itemDes", "");

}
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Item Management</title>
</head>
<body>

	<h1>Items Management</h1>
	<form method="post" action="items.jsp">
		Item code: <input name="itemCode" type="text"
			value='<%=session.getAttribute("itemCode")%>'><br>
		Item name: <input name="itemName" type="text"
			value='<%=session.getAttribute("itemName")%>'><br>
		Item price: <input name="itemPrice" type="text"
			value='<%=session.getAttribute("itemPrice")%>'><br>
		Item description: <input name="itemDesc" type="text"
			value=' <%=session.getAttribute("itemDes")%>'><br> <input
			name="myId" type="hidden"
			value='<%=session.getAttribute("itemID")%>'> <input
			name="btnSubmit" type="submit" value="Save">
	</form>

	<%
	out.print(session.getAttribute("statusMsg"));
	%>

	<br>

	<%
	// call the readItems method

	Item itemObj = new Item();
	out.print(itemObj.readItems());
	%>

	<br>

	<%
	out.print(session.getAttribute("removeStatus"));
	%>

</body>
</html>