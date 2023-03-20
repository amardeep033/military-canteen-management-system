<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet" type="text/css" href="nav.css">
<title>
Admin Dashboard
</title>
</head>

<body>

	<div class="sidenav">
			<h2 style="font-family:Arial; color:white; text-align:center;"> Military Canteen Management System </h2>
			<p style="margin-top:-20px;color:white;line-height:1;font-size:12px;text-align:center">Developed by: Abhiuday & Amardeep	</p>
			<a href="adminmainpage.php">Dashboard</a>
			<button class="dropdown-btn">Inventory
			<i class="down"></i>
			</button>
			<div class="dropdown-container">
				<a href="inventory-add.php">Add New Product</a>
				<a href="inventory-view.php">Manage Inventory</a>
			</div>
			<button class="dropdown-btn">Employees
			<i class="down"></i>
			</button>
			<div class="dropdown-container">
				<a href="employee-add.php">Add New Employee</a>
				<a href="employee-view.php">Manage Employee</a>
			</div>
			<button class="dropdown-btn">Personnel
			<i class="down"></i>
			</button>
			<div class="dropdown-container">
				<a href="customer-add.php">Add New Personnel</a>
				<a href="customer-view.php">Manage Personnel</a>
			</div>
			<a href="sales-view.php">View Sales Invoice Details</a>
			<a href="salesitems-view.php">View Sold Products Details</a>
			<a href="pos1.php">Add New Sale</a>
			<button class="dropdown-btn">Reports
			<i class="down"></i>
			</button>
			<div class="dropdown-container">
				<a href="stockreport.php">Products - Low Stock</a>
				<a href="salesreport.php">Transactions Reports</a>
			</div>
	</div>

	<div class="topnav">
		<a href="logout.php">Logout</a>
	</div>
	
	<center>
	<div class="head">
	<h2> ADMIN DASHBOARD </h2>
	</div>
	</center>
	
	<a href="pos1.php" title="Add New Sale">
	<img src="carticon1.png" style="padding:8px;margin-left:450px;margin-top:40px;width:200px;height:200px;" alt="Add New Sale">
	</a>
	
	<a href="inventory-view.php" title="View Inventory">
	<img src="inventory.png" style="padding:8px;margin-left:100px;margin-top:40px;width:200px;height:200px;" alt="Inventory">
	</a>
	
	<a href="employee-view.php" title="View Employees">
	<img src="emp.png" style="padding:8px;margin-left:100px;margin-top:40px;width:200px;height:200px;" alt="Employees List">
	</a>
	<br>
	<a href="salesreport.php" title="View Transactions">
	<img src="moneyicon.png" style="padding:8px;margin-left:550px;margin-top:40px;width:200px;height:200px;" alt="Transactions List">
	</a>
	
	<a href="stockreport.php" title="Low Stock Alert">
	<img src="alert.png" style="padding:8px;margin-left:100px;margin-top:40px;width:200px;height:200px;" alt="Low Stock Report">
	</a>
	
	
</body>

<script>
	var dropdown = document.getElementsByClassName("dropdown-btn");
	var i;

	for (i = 0; i < dropdown.length; i++) {
	  dropdown[i].addEventListener("click", function() {
	  this.classList.toggle("active");
	  var dropdownContent = this.nextElementSibling;
	  if (dropdownContent.style.display === "block") {
	  dropdownContent.style.display = "none";
	  } else {
	  dropdownContent.style.display = "block";
	  }
	  });
	}
</script>



</html>