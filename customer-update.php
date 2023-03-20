<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet" type="text/css" href="nav.css">
<link rel="stylesheet" type="text/css" href="formD.css">
<title>
Customers
</title>
</head>

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
	<h2> UPDATE PERSONNEL DETAILS</h2>
	</div>
	</center>


	<div class="one">
		<div class="row">
		
	<?php
		
		include "config.php";
		
		if(isset($_GET['id']))
		{
			$id=$_GET['id'];
			$qry1="SELECT * FROM customer WHERE c_id='$id'";
			$result = $conn->query($qry1);
			$row = $result -> fetch_row();
		}

		if( isset($_POST['update']))
		 {
			$id = $_POST['cid'];
			$fname = $_POST['cfname'];
			$lname = $_POST['clname'];
			$age = $_POST['age'];
			$sex = $_POST['sex'];
			$phno = $_POST['phno'];
			$mail = $_POST['emid'];
			 
		$sql="UPDATE customer SET c_fname='$fname',c_lname='$lname',c_age='$age',c_rank='$sex',c_phno='$phno',c_mail='$mail' where c_id='$id'";
		if ($conn->query($sql))
		header("location:customer-view.php");
		else
		echo "<p style='font-size:8; color:red;'>Error! Unable to update.</p>";
		}

	?>
			<form action="<?=$_SERVER['PHP_SELF']?>" method="post">
				<div class="column">
					<p>
						<label for="cid">Personnel ID:</label><br>
						<input type="number" name="cid" value="<?php echo $row[0]; ?>" readonly>
					</p>
					<p>
						<label for="cfname">First Name:</label><br>
						<input type="text" name="cfname" value="<?php echo $row[1]; ?>">
					</p>
					<p>
						<label for="clname">Last Name:</label><br>
						<input type="text" name="clname" value="<?php echo $row[2]; ?>">
					</p>
					<p>
						<label for="age">Age:</label><br>
						<input type="number" name="age" value="<?php echo $row[3]; ?>">
					</p>
					
					<p>
						<label for="sex">Rank: </label><br>
						<input type="text" name="sex" value="<?php echo $row[4]; ?>">
					</p>
					
				</div>
				<div class="column">
					
					<p>
						<label for="phno">Phone Number: </label><br>
						<input type="number" name="phno" value="<?php echo $row[5]; ?>">
					</p>
					<p>
						<label for="emid">Email ID:</label><br>
						<input type="text" name="emid" value="<?php echo $row[6]; ?>">
					</p>
				</div>
			
			<input type="submit" name="update" value="Update">
			
			</form>
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