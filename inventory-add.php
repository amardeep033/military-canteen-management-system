<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="nav.css">
<link rel="stylesheet" type="text/css" href="formD.css">
<title>
Inventory Add
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
	<h2> ADD PRODUCT DETAILS</h2>
	</div>
	</center>
	
	
	<br><br><br><br><br><br><br><br>
	
	
	<div class="one">
		<div class="row">
			<form action="<?=$_SERVER['PHP_SELF']?>" method="post">
				<div class="column">
					<p>
						<label for="medid">Product ID:</label><br>
						<input type="number" name="medid">
					</p>
					<p>
						<label for="medname">Product Name:</label><br>
						<input type="text" name="medname">
					</p>
					<p>
						<label for="qty">Quantity:</label><br>
						<input type="number" name="qty">
					</p>
					<p>
						<label for="cat">Category:</label><br>
						<select id="cat" name="cat">
								<option>General</option>
								<option>Liquor</option>
								<option>Special </option>
						</select>
					</p>
					
				</div>
				<div class="column">
					
					<p>
						<label for="sp">Price: </label><br>
						<input type="number" step="0.01" name="sp">
					</p>
					<p>
						<label for="loc">Location:</label><br>
						<input type="text" name="loc">
					</p>
				</div>
				
			
			<input type="submit" name="add" value="Add Product">
			</form>
		<br>
		
		
	<?php
	
		include "config.php";
		 
		if(isset($_POST['add']))
		{
		$id = mysqli_real_escape_string($conn, $_REQUEST['medid']);
		$name = mysqli_real_escape_string($conn, $_REQUEST['medname']);
		$qty = mysqli_real_escape_string($conn, $_REQUEST['qty']);
		$category = mysqli_real_escape_string($conn, $_REQUEST['cat']);
		$sprice = mysqli_real_escape_string($conn, $_REQUEST['sp']);
		$location = mysqli_real_escape_string($conn, $_REQUEST['loc']);

		 
		$sql = "INSERT INTO products VALUES ($id, '$name', $qty,'$category',$sprice, '$location')";
		if(mysqli_query($conn, $sql)){
			echo "<p style='font-size:8;'>Product details successfully added!</p>";
		} else{
			echo "<p style='font-size:8; color:red;'>Error! Check details.</p>";
		}
		}
		 
		$conn->close();
	?>
		</div>
	</div>
			
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


